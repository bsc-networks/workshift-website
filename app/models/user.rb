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
                  :display_phone_number

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

  def self.create_weekly_hours_report
    report = ''
    CSV.generate(report) do |csv|
      User.all.each do |user|
        csv << [user.name, user.weekly_hours]
      end
    end
    WeeklyReport.create(report: report)
  end

  # Update the total hours balance for every user by adding their current
  # weeks balance, then reset the weekly balance to 0
  def self.update_weekly_hours
    User.all.each do |user|
      user.hours_balance += user.weekly_hours
      user.weekly_hours = 0
      user.save
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
