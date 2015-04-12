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

Then /^only (\d+) person is left in the database$/ do |num_people|
  num_people = num_people.to_i
  expect(User.count).to eq num_people
end

Given /^(\d+) residents exist$/ do |num_people|
  num_people = num_people.to_i
  FactoryGirl.create_list(:user, num_people)
end

Given /^a resident named "(.+)" exists$/ do |name|
  FactoryGirl.create(:user, name: name)
end

Then /^every resident's name should be visible$/ do
  User.all.each do |user|
    expect(page).to have_content(user.name)
  end
end

Given /^the following residents exist:$/ do |resident_table|
  resident_table.hashes.each do |resident|
    User.create!(resident)
  end
end
