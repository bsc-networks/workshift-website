Given /^the date is currently (.+)$/ do |time|
  new_time = Time.local(time)
  Timecop.freeze(new_time)
end
