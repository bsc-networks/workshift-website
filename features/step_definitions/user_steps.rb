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

def simulate_login(user)
  User.create!(user)
  visit path_to('the home page')
  fill_in('email', :with => user["email"])
  fill_in('password', :with => user["password"])
  click_button("Sign In")
end

Given /^I am logged in as an admin$/ do
  admin_user = {"first_name"=>"Example", "last_name"=>"Admin", "email"=>"coop_admin@berkeley.edu", "password"=>"admin", "permissions"=>"2"}
  simulate_login(admin_user)
end

Given /^I am logged in as a non-admin$/ do
  regular_user = {"first_name"=>"Example", "last_name"=>"Non-Admin", "email"=>"non_admin@berkeley.edu", "password"=>"nonadmin", "permissions"=>"0"}
  simulate_login(regular_user)
end

Given /^I am logged in as a workshift manager$/ do
    step "I am logged in as an admin"
end

Given /^I am logged in as a user$/ do
  step "I am logged in as a non-admin"
end

Then /^I should have admin rights$/ do
  pending # Write code here that turns the phrase above into concrete actions
end