require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

module Clockwork
  handler do |job, time|
    logger.info "Running #{job} at time #{time}"
  end

  every(1.week, 'update.resident.weekly.hours', at: 'Tuesday 00:00') do
    WeeklyReport.create!
  end
end
