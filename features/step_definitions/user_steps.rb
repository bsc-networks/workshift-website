Then /^my (.+) should be "(.+)"$/ do |param, value|
  assert(@user.has_attribute?(param),
         "'#{param}' is not a valid parameter of a User.")
  @user.reload
  true_value = @user.read_attribute(param)
  assert((true_value == value),
         "The value of parameter #{param} #{true_value} did not match #{value}")
end

Given /^my (.+) is "(.+)"$/ do |param, value|
  assert(@user.has_attribute?(param),
         "'#{param}' is not a valid parameter of a User.")
  @user.update_attribute(param, value)
end

When /^I save my setting preferences$/ do
  fill_in 'Current password', with: @password
  click_button 'Update User'
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
