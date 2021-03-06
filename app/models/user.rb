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
#  unit_level_admin       :boolean
#  phone_number           :string(255)      default("")
#  room_number            :string(255)      default("")
#  display_phone_number   :boolean          default(FALSE)
#  display_email          :boolean          default(FALSE)
#  schedule               :text             default("")
#
require 'csv'

class User < ActiveRecord::Base
  belongs_to :unit

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
                  :display_phone_number, :schedule, :required_hours,
                  :hours_balance, :unit

  after_create :init_schedule

  serialize :schedule, Hash

  # Invites each of the users whose information is contained in the input,
  # which must be formatted as a comma-separated string with names in the
  # first column and email addresses in the second.
  def self.invite_users(user_info, unit)
    fail ArgumentError, 'Must input at least one userattr_accessible' if user_info.length == 0
    num_invited = 0
    CSV.parse(user_info) do |row|
      fail ArgumentError, 'Improperly formatted user information on row '\
        "#{num_invited + 1}" if row.length != 2
      User.invite!(name: row[0].strip, email: row[1].strip, unit:unit)
      num_invited += 1
    end
    num_invited
  end

  def self.invite_users_in_units(user_info)
    fail ArgumentError, 'Must input at least one userattr_accessible' if user_info.length == 0
    num_invited = 0
    CSV.parse(user_info) do |row|
      fail ArgumentError, 'Improperly formatted user information on row '\
        "#{num_invited + 1}" if row.length != 3
      if row[2] == nil or Unit.find_by_name(row[2].strip) == nil
        fail ArgumentError, 'No such unit exists on row '\
        "#{num_invited + 1}"
      end
      User.invite!(name: row[0].strip, email: row[1].strip, unit: Unit.find_by_name(row[2].strip))
      num_invited += 1
    end
    num_invited
  end

  def self.delete_all_residents(unit)
    User.where(unit_id: unit).where(admin: false).where(workshift_manager: false).where(unit_level_admin: false).destroy_all
    WeeklyReport.where(unit_id: unit).destroy_all
  end

  # Create a new preference for the inputted category for each user. The rank
  # of the preference should place it as the least prefered category.
  def self.create_preferences(category)
    User.where(unit_id: category.unit).each do |user|
      rank = Category.count
      Preference.create!(user_id: user.id, category_id: category.id,
                         rank: rank)
    end
  end

  # calculates the number of hours up or down a user is for a given week,
  # where DATE is a DateTime object
  def hours_for_week(date)
    start_date = date.monday - 1.week - 1.day
    end_date = (date - 1.week).sunday - 1.day
    users_shifts = WorkshiftAssignment.where(workshifter_id: id,
                                             date: start_date..end_date)
    hours = 0
    users_shifts.each do |shift|
      hours += shift.hours * shift.hours_multiplier
    end
    hours - required_hours
  end

  # calculates whether or not each user is assigned to at least their
  # weekly required hours amount and updates their up/down count
  def self.update_all_users_weekly_hours
    Time.zone = "UTC"
    Chronic.time_class = Time.zone
    current_week_end = Chronic.parse "last Saturday at 23:59"
    current_week_start = current_week_end - 1.week
    User.where(unit_id: current_user.unit).each do |user|
      users_shifts = WorkshiftAssignment.where(workshifter_id: user,
                                               date: current_week_start..current_week_end)
      assigned_hours = users_shifts.sum(:hours)
      if assigned_hours < user.required_hours
        user.hours_balance -= (user.required_hours - assigned_hours)
        user.save!
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
        new_schedule[day][hour] = true
      end
    end
    new_schedule
  end

  def init_schedule
    self.schedule = User.create_schedule
    self.save!
  end

  # Time slots for a student schedule
  def self.available_hours
    %w(6-7AM 7-8AM 8-9AM 9-10AM 10-11AM 11-12PM 12-1PM 1-2PM
       2-3PM 3-4PM 4-5PM 5-6PM 6-7PM 7-8PM 8-9PM 9-10PM)
  end

  # Days for a student schedule
  def self.available_days
    Date::DAYNAMES
  end

  # Parses the schedule params from views and returns the appropriate
  # schedule hash
  def self.parse_schedule_params(schedule_params)
    new_schedule = User.create_schedule
    schedule_params.each do |day, times|
      times.each do |time, free|
        new_schedule[day][time] = (free == 'yes')
      end
    end
    new_schedule
  end

  def update_required_hours(hours)
    if hours % 0.5 != 0
      fail ArgumentError, 'Required hours must be divisible by 0.5'
    end
    self.required_hours = hours
    self.save!
  end

  def update_unit(unit)
    self.unit = unit
    self.save!
  end

  def needed_hours
    required_hours - workshifts.sum(:hours)
  end

  def hours_assigned_class
    assignment_deficit = needed_hours
    if assignment_deficit <= 0
      return ''
    else
      return 'down_hours'
    end
  end

  def hours_balance_class
    if hours_balance == 0
      return ''
    elsif hours_balance < 0
      return 'down_hours'
    else
      return 'up_hours'
    end
  end

  def role
    if workshift_manager?
      return 'Workshift Manager'
    end
    if unit_level_admin?
      return 'Unit-Level Admin'
    end
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
