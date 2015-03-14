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


