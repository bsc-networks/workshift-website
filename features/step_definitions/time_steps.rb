require 'date'
Given /^the date is currently (.+)$/ do |time|
  new_time = DateTime.parse(time).to_time
  Timecop.freeze(new_time)
end
