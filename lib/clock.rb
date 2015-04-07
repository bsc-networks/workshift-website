require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

module Clockwork
  handler do |job, time|
    logger.info "Running #{job} at time #{time}"
  end

  every(1.week, 'create.workshift.assignments', at: 'Monday 00:00') do
    Workshift.create_assignments
  end

  every(1.week, 'update.resident.weekly.hours', at: 'Monday 00:00') do
    User.create_weekly_hours_report
    User.update_weekly_hours
  end
end
