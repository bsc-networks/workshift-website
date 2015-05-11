Given /^I have an account with email "(.+)" and password "([^"]+)"(?: and name "(.+)")?$/ do |email, password, name|
  name ||= 'Test User'
  @user = User.create!(email: email, password: password,
                       password_confirmation: password, name: name)
end

Given /^I am a workshift manager with email "(.*)" and password "([^"]+)"(?: and name "(.+)")?$/ do |email, password, name|
  name ||= 'Test User'
  step "I have an account with email \"#{email}\" and password \"#{password}\""\
    " and name \"#{name}\""
  @user.update_attribute :workshift_manager, true
  @user.save!
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

Given /^I (?:am signed in|sign in) as a resident$/ do
  email = 'resident@example.com'
  password = 'secret'
  step "I have an account with email \"#{email}\" and password \"#{password}\""
  step "I sign in using email \"#{email}\" and password \"#{password}\""
end

Given /^I am signed in as a resident named "(.+)"$/ do |name|
  email = "#{name.gsub(' ', '_')}@example.com"
  password = 'secret'
  step "I have an account with email \"#{email}\" and password \"#{password}\" and name \"#{name}\""
  step "I sign in using email \"#{email}\" and password \"#{password}\""
end

Given /^I am signed in as a workshift manager$/ do
  email = 'manager@example.com'
  password = 'secret'
  step "I am a workshift manager with email \"#{email}\" and password "\
    "\"#{password}\""
  step "I sign in using email \"#{email}\" and password \"#{password}\""
end

Given /^I am not signed in$/ do
  step 'I log out'
end

When /^I log out$/ do
  visit logout_path
end

Then /^I should be signed in$/ do
  step 'I should see "Logout"'
end
