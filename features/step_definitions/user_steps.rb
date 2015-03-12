Given (/^I have an account with email "(.+)" and password "([^"]+)"(?: and name "(.+)")?$/) do |email, password, name|
  name ||= 'Test User'
  User.new(email: email, password: password, password_confirmation: password,
           name: name).save!
end

Given (/^I am signed in using email "(.+)" and password "([^"]+)"/) do |email, password|
  visit login_path
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'Sign In'
end

Given /^I am signed in as an authenticated user$/ do
  email = 'test@example.com'
  password = 'secret'
  step "I have an account with email \"#{email}\" and password \"#{password}\""
  visit login_path
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'Sign In'
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

Then /^I should be able to log in with the following:$/ do |login_info|
  visit login_path
  login_info.rows_hash do |email, password|
    fill_in 'Current email', with: email
    fill_in 'user_password', with: password
    # => visit login_path
    #fill_in 'user_email', with: email
    #fill_in 'user_password', with: password
    click_button 'Sign In'
  end
end

When (/^I am a workshift manager with email "(.*)" and name "(.*)"/) do |email, name|
  name ||= 'Test User'
  password ||= 'secret'
  user = User.new(email: email, password: password, password_confirmation: password,
           name: name)
  user.update_attribute :workshift_manager, true
  user.save!
  visit login_path
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'Sign In'
end
