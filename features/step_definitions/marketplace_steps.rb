Given /^I put my workshift on the market before the deadline$/ do
  # need the sleeps to prevent database locking issues with Rufus
  @assignment = WorkshiftAssignment.where(workshift_id: @workshift.id,
                                          workshifter_id: @user.id).first
  step 'my assignment has not started yet'
  @assignment.put_on_market
end

Given /^I put my workshift on the market after the deadline$/ do
  @assignment = WorkshiftAssignment.where(workshift_id: @workshift.id,
                                          workshifter_id: @user.id).first
  step 'my assignment is awaiting check off'
  visit user_profile_path(@user)
  step 'I press "Sell"'
end

Then /^I can see my workshift on the marketplace$/ do
  visit marketplace_path
  step "I should see \"#{@workshift.task}\""
end

When /^someone buys the shift$/ do
  buyer = User.find_by_name('Buyer')
  buyer ||= FactoryGirl.create(:user, name: 'Buyer',
                                      email: 'buyer@example.com', unit: Unit.find_or_create_by_id(id: 1, name: 'Unit 1'))
  @assignment.sell_to(buyer)
end

Then /^I should see the workshift as sold$/ do
  visit user_profile_path(@user)
  step 'I should see "sold"'
end

Given /^no one buys my shift and the workshift has passed$/ do
  step 'I can see my workshift on the marketplace'
  Timecop.freeze(Time.now + 24.hours)
end

Then /^I should see the workshift as missed$/ do
  visit user_profile_path(@user)
  expect(page).to_not have_content('sold')
end

Given /^no one buys my shift and the workshift has not started yet$/ do
  step 'I can see my workshift on the marketplace'
  Timecop.freeze(Time.now - 200.hours)
end

Then /^I should not see my workshift in the Marketplace$/ do
  visit marketplace_path
  step "I should not see \"#{@workshift.task}\""
end

Then /^I should see my workshift in the Marketplace$/ do
  step "I should see \"#{@workshift.task}\""
end
