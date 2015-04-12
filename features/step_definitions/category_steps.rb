Given /^the following categories exist:$/ do |categories_table|
  categories_table.hashes.each do |category|
    Category.create!(category)
  end
end

Given /^the category "(.+)" exists$/ do |name|
  FactoryGirl.create(:category, name: name)
end

Then /^there should be a category with (?:|the )name "(.+)"$/ do |name|
  expect(Category.find_by_name(name)).to_not be_nil
end
