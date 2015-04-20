Given(/^I am assigned to the following shift:$/) do |table|
  # table is a Cucumber::Ast::Table
  step 'I am assigned to the shift "Dishes"'
  WorkshiftAssignment.assign_workshifter(user)
  WorkshiftAssignment.put_on_market(user)

  pending # express the regexp above with the code you wish you had
end

Given(/^there is more than (\d+) hours until my shift starts$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given(/^I sell my shift$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I put my workshift on the market$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I can see my workshift on the marketplace$/) do
  pending # express the regexp above with the code you wish you had
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