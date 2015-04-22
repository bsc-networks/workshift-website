When /^(?:|I )check the box in column "(.+)" and row "(.+)"$/ do |day, hour|
  check("schedule_#{day}_#{hour}")
end

Then /^the box in column "(.+)" and row "(.+)" should be checked$/ do |day, hour|
  find_by_id("schedule_#{day}_#{hour}").should be_checked
end
