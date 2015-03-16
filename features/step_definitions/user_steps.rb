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
