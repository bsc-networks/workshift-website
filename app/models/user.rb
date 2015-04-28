# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  workshift_manager      :boolean
#  phone_number           :string(255)      default("")
#  room_number            :string(255)      default("")
#  display_phone_number   :boolean          default(FALSE)
#  display_email          :boolean          default(FALSE)
#  schedule               :text             default("")
#
require 'csv'

class User < ActiveRecord::Base
  has_many :workshift_assignments, foreign_key: 'workshifter_id'
  has_many :preferences
  has_many :verified_workshifts, class_name: 'WorkshiftAssignment',
                                 foreign_key: 'verifier_id'
  has_many :workshifts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :room_number, :phone_number, :display_email,
                  :display_phone_number, :schedule, :required_hours, :hours_balance

  serialize :schedule, Hash

  # Invites each of the users whose information is contained in the input,
  # which must be formatted as a comma-separated string with names in the
  # first column and email addresses in the second.
  def self.invite_users(user_info)
    fail ArgumentError, 'Must input at least one user' if user_info.length == 0
    num_invited = 0
    CSV.parse(user_info) do |row|
      fail ArgumentError, 'Improperly formatted user information on row '\
        "#{num_invited + 1}" if row.length != 2
      User.invite!(name: row[0].strip, email: row[1].strip)
      num_invited += 1
    end
    num_invited
  end

  def self.delete_all_residents
    User.where(workshift_manager: false).destroy_all
    WeeklyReport.destroy_all
  end

  # Create a new preference for the inputted category for each user. The rank
  # of the preference should place it as the least prefered category.
  def self.create_preferences(category)
    User.all.each do |user|
      rank = Category.count
      Preference.create!(user_id: user.id, category_id: category.id,
                         rank: rank)
    end
  end

  # Update the total hours balance for every user by adding their current
  # weeks balance, then reset the weekly balance to 0
  # def self.update_weekly_hours
  #   User.all.each do |user|
  #     user.hours_balance += user.weekly_hours
  #     user.weekly_hours = 0
  #     user.save
  #   end
  # end
  
  # calculates whether or not each user is assigned to at least their
  # weekly required hours amount and updates their up/down count
  def self.update_all_users_weekly_hours
    Time.zone = "UTC"
    Chronic.time_class = Time.zone
    current_week_end = Chronic.parse "last Saturday at 23:59"
    current_week_start = current_week_end - 1.week
    User.all.each do |user|
      users_shifts = WorkshiftAssignment.where("workshifter_id = ? and date > ? and date < ?", user, current_week_start, current_week_end)
      assigned_hours = users_shifts.sum(:hours)
      if assigned_hours < user.required_hours
        user.hours_balance -= (user.required_hours - assigned_hours)
      end
    end
  end

  # Creates an empty schedule for the user
  def self.create_schedule
    hours = available_hours
    days = available_days
    new_schedule = Hash.new do |hash, key|
      hash[key] = Hash.new do |hash, key|
        hash[key] = false
      end
    end
    days.each do |day|
      hours.each do |hour|
        new_schedule[day][hour] = false
      end
    end
    new_schedule
  end

  #Time slots for a student schedule
  def self.available_hours
    %w(8-9AM 9-10AM 10-11AM 11-12PM 12-1PM 1-2PM 2-3PM 3-4PM
       4-5PM 5-6PM 6-7PM 7-8PM 8-9PM)
  end

  #Days for a student schedule
  def self.available_days
    Date::DAYNAMES
  end

  #Parses the schedule params from views and returns the appropriate schedule hash
  def self.parse_schedule_params(schedule_params)
    new_schedule = User.create_schedule
    schedule_params.each do |day, times|
      times.each do |time, free|
        if free == "yes" then
          new_schedule[day][time] = true
        else
          new_schedule[day][time] = false
        end
      end
    end
    return new_schedule
  end

  def update_required_hours(hours)
    if hours % 0.5 != 0
      fail ArgumentError, "Required hours must be divisible by 0.5"
    end
    self.required_hours = hours
    self.save!
  end

  def hours_balance_class
    if hours_balance == 0
      return ""
    elsif hours_balance < 0
      return "down_hours"
    else
      return "up_hours"
    end
  end

  def role
    return 'Workshift Manager' if workshift_manager?
    'Resident'
  end

  def sorted_preferences
    preferences.sort { |a, b| a.rank <=> b.rank }
  end

  def update_category_preferences(preferences)
    validate_preferences(preferences)
    preferences.each do |category_id, rank|
      pref = Preference.where(user_id: id, category_id: category_id).first
      pref ||= Preference.create(user_id: id, category_id: category_id)
      pref.rank = rank
      pref.save
    end
  end

  private

  def validate_preferences(preferences)
    if preferences.value? '0'
      category_id = preferences.key('0')
      category = Category.find(category_id)
      fail ArgumentError, "No rank selected for category #{category.name}."
    end
    unless preferences.values.uniq.length == preferences.values.length
      fail ArgumentError, 'Please select each ranking only once.'
    end
  end
end
