Given(/^I am assigned to the shift "(.*?)" with start time "(.*?)" and end time "(.*?)" with day "(.*?)"$/) do |task, start_time, end_time, day|
  @user = FactoryGirl.create(:user, name: "Seller")
  FactoryGirl.create(:workshift, task: task, start_time: start_time, end_time: end_time, day: day)
  step "I am signed in as a resident"
end

Given(/^I put my workshift "(.*?)" on the market before the deadline$/) do |shift|
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

Given(/^I put my workshift "(.*?)" on the market after the deadline$/) do |shift|
  workshift = Workshift.find_by_task(shift)
  @assignment = workshift.assign_worker(@user)
  shift_start_time = @assignment.begin_workshift_date
  deadline = @assignment.begin_workshift_date - 24.hours
  Timecop.freeze(deadline+ 24.hours) 
  @assignment.put_on_market
end

Then(/^I should see an error$/) do
  visit user_profile_path(@user)
  step "I should see \"Dishes\""
end


Then(/^I can see my workshift on the marketplace$/) do
  #pending # express the regexp above with the code you wish you had
  visit marketplace_path
  step "I should see \"Dishes\""
end

Given(/^someone buys shift "(.*?)" with start time "(.*?)" and end time "(.*?)" with day "(.*?)"$/) do |task, start_time, end_time, day|
  #pending # express the regexp above with the code you wish you had
  buyer= FactoryGirl.create(:user, name: "Buyer")
  #@user = FactoryGirl.create(:user, name: "seller")
  #FactoryGirl.create(:workshift, task: task, start_time: start_time, end_time: end_time, day: day )
  #step "I am signed in as a resident"
  step "I put my workshift \"Dishes\" on the market before the deadline"
  @assignment.sell_to(buyer)
end



Then(/^I should see the workshift as sold$/) do
  #pending # express the regexp above with the code you wish you had
  
  visit user_profile_path(@user)
  step "I should see \"sold\""
end

Given(/^no one buys my shift "(.*?)" and the workshift has passed$/) do |shift|
  #pending # express the regexp above with the code you wish you had
  step "I can see my workshift on the marketplace"
  Timecop.freeze(Time.now+ 24.hours) 
  #visit user_profile_path(@user)
  
end

Then(/^I should see the workshift as missed$/) do
  #pending # express the regexp above with the code you wish you had
  visit user_profile_path(@user)
  expect(page).to_not have_content("sold")
end

Given(/^no one buys my shift and the workshift has not started yet$/) do
  #pending # express the regexp above with the code you wish you had
  Timecop.freeze(Time.now- 200.hours)
end

Given(/^I click "(.*?)"$/) do |click|
  #pending # express the regexp above with the code you wish you had
  step "I put my workshift \"Dishes\" on the market before the deadline"
  step "I can see my workshift on the marketplace"
  visit marketplace_path
  click_button(click)
end

Then(/^I should not see my workshift in the Marketplace$/) do
  #pending # express the regexp above with the code you wish you had
  visit marketplace_path
  step "I should not see \"Dishes\""
end


Then(/^I should see my workshift in the Marketplace$/) do
  #pending # express the regexp above with the code you wish you had
  step "I should see \"Dishes\""

end
