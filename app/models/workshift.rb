# == Schema Information
#
# Table name: workshifts
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  start_time    :time
#  end_time      :time
#  day           :integer
#  people_needed :integer
#  description   :text
#  task          :string(255)
#  hours         :integer
#
class Workshift < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :workshift_assignments
  attr_accessible :start_time, :end_time, :day, :task, :category_id,
                  :description, :hours
  # after_create :apply_time_zone
  validates :start_time, :end_time, :day, :task, :hours,
            :description, presence: true
  validates :day, numericality: { only_integer: true,
                                  greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 6 }
  validate :end_time_later_than_start_time # not working w/ timezones
  validate :multiple_of_5?

  def assign_worker(uid)
    worker = User.find_by_id(uid)
    if worker != self.user
      self.user = worker
      # to delete or not to delete old user's current assignment
      # generate new assignment for new user immediately
      assignment = generate_next_assignment
      self.save!
      return assignment
    end
  end

  def generate_next_assignment
    Time.zone = "UTC"
    Chronic.time_class = Time.zone
    assignment_date = Chronic.parse "this #{self.weekday} at 0:00"
    assignment = self.workshift_assignments.create!({
        task: self.task,
        description: self.description,
        date: assignment_date,
        start_time: start_time,
        end_time: end_time,
        hours: self.hours,
        status: "upcoming",
        purchased: false
    })
    assignment.assign_workshifter(self.user)
    assignment.save!
    assignment
  end

  def end_time_later_than_start_time
    return if end_time > start_time
    errors.add(:end_time, 'must be later than the starting time.')
  end

  def multiple_of_5?
    return if hours.nil?
    return if (hours * 10) % 5 == 0 # if hours*10 is divisible by 5: 1.5 ->15
    errors.add(:hours, 'must be in half hour increments.')
  end

  def self.valid_days
    days = []
    7.times do |i|
      days << [Date::DAYNAMES[i], i]
    end
    days
  end

  def self.time_to_hour_string(time)
    hour = time.hour
    if hour <= 12
      period = (hour > 10) ? "PM" : "AM"
      if (hour == 12)
        hour_string = "12-1PM"
      else
        hour_string = "#{hour}-#{hour+1}#{period}"
      end
    else
      hour -= 12 # adjust for AM/PM system
      period = (hour == 11) ? "AM" : "PM"
      hour_string = "#{hour}-#{hour+1}#{period}"
    end
    hour_string
  end

  def end_to_start_hours
    end_time.hour - start_time.hour
  end

  def unavailability_of(user)
    hour = start_time
    unavailability = []
    while hour < end_time
      formatted_hour = Workshift.time_to_hour_string(hour)
      if !user.schedule[weekday][formatted_hour]
        unavailability << formatted_hour
      end
      hour += 1.hour
    end
    unavailability
  end

  def best_assignment_candidates
    best_candidates = {
      highest_pref: [],
      most_needed_hours: []
    }
    available = []
    User.all.each do |user|
      user_unavailability = unavailability_of(user)
      if user_unavailability.length != end_to_start_hours
        # if user is not completely unavailable
        available << [user, user_unavailability]
      end
    end
    best_candidates[:highest_pref] = available.sort do |a, b| 
      a_rank = a[0].preferences.where("category_id = ?", category).first.rank
      b_rank = b[0].preferences.where("category_id = ?", category).first.rank
      a_rank <=> b_rank
    end
    best_candidates[:most_needed_hours] = available.sort do |a, b|
      #a_hours = a[0].required_hours - a[0].
    end
  end

  def weekday
    # return unless day >= 0 && day <= 6
    Date::DAYNAMES[day]
  end

  def category_name
    return category.name unless category.nil?
    'Uncategorized'
  end

  def formatted_start_time
    start_time.strftime('%l:%M %p')
  end

  def formatted_end_time
    end_time.strftime('%l:%M %p')
  end
end
