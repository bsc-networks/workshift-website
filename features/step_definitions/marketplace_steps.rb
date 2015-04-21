

Given(/^I am assigned to the shift "(.*?)" with start time "(.*?)" and end time "(.*?)" with day "(.*?)"$/) do |task, start_time, end_time, day|
  @user = FactoryGirl.create(:user)
  FactoryGirl.create(:workshift, task: task, start_time: start_time, end_time: end_time, day: day )
  step "I am signed in as a resident"
end

Given(/^I put my workshift "(.*?)" on the market before the (\d+) hour deadline$/) do |shift, hour_deadline|
  #Timecop.freeze(Time.zone.local(2015, 4, 20))
  #Workshift.put_on_market
  #assign_worker
  workshift = Workshift.find_by_task(shift)
  @assignment = workshift.assign_worker(@user)
  shift_start_time = @assignment.begin_workshift_date
  deadline = @assignment.begin_workshift_date - 24.hours
  Timecop.freeze(deadline- 24.hours) 
  @assignment.put_on_market
end


Then(/^I can see my workshift on the marketplace$/) do
  #pending # express the regexp above with the code you wish you had
  visit marketplace_path
  step "I should see \"Dishes\""
end

Given(/^someone buys shift$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should only lose the shift's hours number of points$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^no one buys my shift and the workshift has passed$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^no one buys my shift and the workshift has not started yet$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I click "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not see my workshift in the Marketplace$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^my shift has not started yet$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see my workshift in the Marketplace$/) do
  pending # express the regexp above with the code you wish you had
end
