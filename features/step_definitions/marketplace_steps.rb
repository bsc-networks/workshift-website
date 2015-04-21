Given(/^I am assigned to the shift "(.*?)" with start time "(.*?)" and end time "(.*?)" with day "(.*?)"$/) do |task, start_time, end_time, day|
  @user = FactoryGirl.create(:user, name: "Seller")
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
  #pending # express the regexp above with the code you wish you had
  buyer= @user = FactoryGirl.create(:user, name: "Buyer")
  @assignment.sell_to(buyer)
end

Then(/^I should see the workshift as sold$/) do
  #pending # express the regexp above with the code you wish you had
  visit marketplace_path
  step "I should see \"Sold\""
end

Given(/^no one buys my shift and the workshift has passed$/) do
  #pending # express the regexp above with the code you wish you had
  Timecop.freeze(deadline+ 24.hours)
  visit marketplace_path
  
end

Then(/^Then I should see the workshift as blown$/) do
  #pending # express the regexp above with the code you wish you had
  visit marketplace_path
  step "I should see \"You can not put a workshift on the marketplace after it has started.\""
end

Given(/^no one buys my shift and the workshift has not started yet$/) do
  #pending # express the regexp above with the code you wish you had
  Timecop.freeze(deadline- 24.hours)
end

Given(/^I click "(.*?)"$/) do |click|
  #pending # express the regexp above with the code you wish you had
  click_button(click)
end

Then(/^I should not see my workshift in the Marketplace$/) do
  #pending # express the regexp above with the code you wish you had
  visit marketplace_path
  step "I should not see \"Dishes\""
end

Given(/^my shift has not started yet$/) do
  #pending # express the regexp above with the code you wish you had
  Timecop.freeze(deadline- 24.hours)
end

Then(/^I should see my workshift in the Marketplace$/) do
  #pending # express the regexp above with the code you wish you had
  step "I should see \"Dishes\""
end
