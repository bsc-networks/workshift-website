Given /the following users exist/ do |users_table|
  # puts users_table
  users_table.hashes.each do |user|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that user to the database here.
    User.create!(user)
  end
  # puts "COUNT: " + User.all.count.to_s
end

Given /none of the uploaders exists/ do
  User.delete_all(["email in (?)", ["ericn@berkeley.edu","gwillits@berkeley.edu",	"yannie.yip@berkeley.edu", 	"ryan.riddle@berkeley.edu"]])
end

Given /^I am logged in as an admin$/ do
  user = User.create!(first_name: "Example", last_name: "Admin", email: "coop_admin@berkeley.edu", password: "admin")
  visit path_to('the home page')
  fill_in('email', :with => 'coop_admin@berkeley.edu')
  fill_in('password', :with => 'admin')
  click_button("Sign In")
end

Given /^I am logged in as a non-admin$/ do
  user = User.create!(first_name: "Example", last_name: "Non-Admin", email: "non_admin@berkeley.edu", password: "nonadmin")
  visit path_to('the home page')
  fill_in('email', :with => 'non_admin@berkeley.edu')
  fill_in('password', :with => 'nonadmin')
end

Given /^I am logged in as a workshift manager$/ do
    step "I am logged in as an admin"
end

Given /^I am logged in as a user$/ do
  step "I am logged in as a non-admin"
end

Then(/^I should have admin rights$/) do
  pending # Write code here that turns the phrase above into concrete actions
end