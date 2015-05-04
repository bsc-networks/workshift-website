When /^I change the new required hours to (.+)$/ do |hour|
	fill_in 'New Required Hours', with: hour
	click_button 'Change Required Hours'
end

Then(/^I should see the Current Required Hours as (\d+)$/) do |arg1|
  expect(page).to have_content(arg1)
end

Then(/^I should not see the Current Required Hours as (\d+)$/) do |arg1|
  expect('Current Required Hours').to_not have_content(arg1)
end

