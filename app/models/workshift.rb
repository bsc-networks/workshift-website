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
  has_many :workshift_assignments
  attr_accessible :start_time, :end_time, :day, :task, :people_needed,
                  :description, :hours

  validates :start_time, :end_time, :day, :task,
            :description, presence: true
  validates :day, numericality: { only_integer: true,
                                  greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 6 }
  validate :end_time_later_than_start_time

  def end_time_later_than_start_time
    return if end_time > start_time
    errors.add(:end_time, 'must be later than the starting time.')
  end

  def self.valid_days
    days = []
    7.times do |i|
      days << [Date::DAYNAMES[i], i]
    end
    days
  end

  def self.create_multiple(params, days)
    # create a workshift with parameters PARAMS for each day in array DAYS.
    # Fails if days is empty or the workshift cannot be saved successfully.
    # returns the last successfully created workshift.
    fail ArgumentError, 'Must select at least one day.' if days.length == 0
    days.each do |day|
      workshift = Workshift.new(params.merge(day: day))
      fail ArgumentError, 'Please fix the problems below:' unless workshift.save
    end
    workshift
  end

  def weekday
    # return unless day >= 0 && day <= 6
    Date::DAYNAMES[day]
  end

  def formatted_start_time
    start_time.strftime('%l:%M %p')
  end

  def formatted_end_time
    end_time.strftime('%l:%M %p')
  end
end
