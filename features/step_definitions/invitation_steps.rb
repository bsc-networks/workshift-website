When /^I try to invite the following users:$/ do |input|
  user_info = input.raw.map(&:first)
  fill_in 'user_info', with: user_info.join("\n")
  click_button 'Invite User'
end

Then /^(\d+) new users should have been invited$/ do |num_invited|
  step "I should see \"Invited #{num_invited} new users.\""
end
