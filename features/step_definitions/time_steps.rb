Given /^the date is currently "(.+)"$/ do |time|
  new_time = Time.parse(time)
  Timecop.freeze(new_time)
end
