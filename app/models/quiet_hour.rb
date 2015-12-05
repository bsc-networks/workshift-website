class QuietHour < ActiveRecord::Base
  belongs_to :unit
  has_many :day_quiet_hours

  attr_accessible :day_quiet_hours, :quiet_hour_id

  def get_day_start_time(day)
    day_quiet_hours.where(day: day).first.start_time
  end

  def get_day_end_time(day)
    day_quiet_hours.where(day: day).first.end_time
  end

  def set_day_start_time(day, start_time)
    if day == 'weekdays'
      ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday'].each do |weekday|
        day_quiet_hours.where(day: weekday).update_all(:start_time => start_time)
      end
    elsif day == 'weekends'
      ['friday', 'saturday'].each do |weekend|
        day_quiet_hours.where(day: weekend).update_all(:start_time => start_time)
      end
    else
      day_quiet_hours.where(day: day).first.update_attributes(:start_time => start_time)
    end
  end

  def set_day_end_time(day, end_time)
    if day == 'weekdays'
      ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'].each do |weekday|
        day_quiet_hours.where(day: weekday).update_all(:end_time => end_time)
      end
    elsif day == 'weekends'
      ['saturday', 'sunday'].each do |weekend|
        day_quiet_hours.where(day: weekend).update_all(:end_time => end_time)
      end
    else
      day_quiet_hours.where(day: day).first.update_attributes(:end_time => end_time)
    end
  end
end