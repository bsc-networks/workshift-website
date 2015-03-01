class Workshift < ActiveRecord::Base
  has_many :assigned_workshifts
  has_many :users, through: :assigned_workshifts
  attr_accessible :start_time, :end_time, :day, :task, :people_needed,
                  :description, :hours

  validates :start_time, :end_time, :day, :task, :people_needed,
            :description, presence: true
  validates :day, numericality: { only_integer: true,
                                  greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 6 }
  validates :people_needed, numericality: { only_integer: true,
                                            greater_than: 0 }
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

  def weekday
    return unless day >= 0 && day <= 6
    Date::DAYNAMES[day]
  end

  def formatted_start_time
    start_time.strftime('%l:%M %p')
  end

  def formatted_end_time
    end_time.strftime('%l:%M %p')
  end

  def num_assigned
    users.length
  end

  def assigned_so_far
    "#{num_assigned}/#{people_needed}"
  end
end
