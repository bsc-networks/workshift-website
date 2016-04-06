Feature: Adding Users
    As a work-shift manager
    I want to be able to upload a csv file with all my members
    To ease the process of creating user accounts
    
Background:
  And I am logged in as an admin
  And I go to the create members page
  And none of the uploaders exists

Scenario: an admin tries to add member accounts using a csv file
  When I upload "users_upload.csv"
  Then I press "Import"
  Then I should see a user table
  And I should see "Giorgia"
  And I should see "Willits"
  And I should see "gwillits@berkeley.edu"
  When I press "Confirm Users"
  Then I should see "Sent confirmation email to users"

Scenario: an admin tries to add member accounts manually
  And I fill in "First Name" with "Eric"
  And I fill in "Last Name" with "Nelson"
  And I fill in "Email" with "ericn@berkeley.edu"
  When I press "Add User"
  And I fill in "First Name" with "Yannie"
  And I fill in "Last Name" with "Yip"
  And I fill in "Email" with "yannie.yip@berkeley.edu"
  Then I press "Add User"
  When I press "Confirm Users"
  Then I should see "Sent confirmation email to users"

Scenario: an admin tries to import no file
  When I press "Import"
  Then I should be on the create members page

  
  
  