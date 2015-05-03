When /^I change the new required hours to (.+)$/ do |hour|
	fill_in 'New Required Hours', with: hour
	click_button 'Change Required Hours'
end
Then /^I should see the Current Required Hours as 5.0$/ do
	expect(page).to have_content("5.0")
end