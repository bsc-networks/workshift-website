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
  expect(User.where(unit_id: 1).count).to eq num_people
end

Given /^(\d+) residents exist$/ do |num_people|
  num_people = num_people.to_i
  FactoryGirl.create_list(:user, num_people)
end

Given /^a resident named "(.+)" exists$/ do |name|
  FactoryGirl.create(:user, name: name, unit: Unit.find_or_create_by_id(id: 1, name: 'Unit 1'),
                            email: "#{name.gsub(' ', '_')}@example.com")
end

Given /^I am a resident named "(.+)"$/ do |name|
  @user = FactoryGirl.create(:user, name: name, unit: Unit.find_or_create_by_id(id: 1, name: 'Unit 1'))
end

Then /^every resident's name should be visible$/ do
  User.where(unit_id: 1).each do |user|
    expect(page).to have_content(user.name)
  end
end

Given /^the following residents exist:$/ do |resident_table|
  resident_table.hashes.each do |resident|
    user = User.create!(resident)
    user.update_attribute :unit, Unit.find_or_create_by_id(id: 1, name: 'Unit 1')
    user.save()
  end
end
