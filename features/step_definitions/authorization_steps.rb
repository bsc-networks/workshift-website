Given /^I have an account with email "(.+)" and password "([^"]+)"(?: and name "(.+)")?$/ do |email, password, name|
  name ||= 'Test User'
  @user = User.create!(email: email, password: password,
                       password_confirmation: password, name: name)
end

Given /^I (?:am signed in|sign in) using email "(.+)" and password "([^"]+)"$/ do |email, password|
  visit login_path
  @password = password
  fill_in 'user_email', with: email
  fill_in 'user_password', with: @password
  click_button 'Sign In'
end

Then /^I can sign in using email "(.+)" and password "([^"]+)"$/ do |email, password|
  step "I sign in using email \"#{email}\" and password \"#{password}\""
  step 'I should be signed in'
end

Given /^I am signed in as an authenticated user$/ do
  email = 'test@example.com'
  password = 'secret'
  step "I have an account with email \"#{email}\" and password \"#{password}\""
  step "I sign in using email \"#{email}\" and password \"#{password}\""
end

Given /^I am not signed in$/ do
  step %Q{I log out}
end

When /^I log out$/ do
  visit logout_path
end

Then /^I should be signed in$/ do
  step 'I should see "Logout"'
end

=begin
When (/^I am a workshift manager with email "(.*)" and name "(.*)"/) do |email, name|
  #to do
end
=end
