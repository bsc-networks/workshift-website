class DayQuietHour < ActiveRecord::Base
  belongs_to :quiet_hour
  attr_accessible :start_time, :end_time, :day, :quiet_hour_id
end
