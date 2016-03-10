Feature: Adding Users

    As a work-shift manager
    I want to be able to upload a csv file with all my members
    To ease the process of creating user accounts
    
Background:
  Given I am on the create members page
  Given none of the uploaders exists

Scenario: an admin tries to add member accounts using a csv file
  When I upload "users_upload.csv"
  Then I press "Import"
  Then I should see a table
  And I should see "Giorgia"
  And I should see "Willits"
  And I should see "gwillits@berkeley.edu"
  When I click "Save"
  Then I should see "Confirmation emails sent to users with account information."
  
Scenario: an admin tries to add member accounts manually
  When I press the add user symbol
  And I fill in "First Name" with "Eric"
  And I fill in "Last Name" with "Nelson"
  And I fill in "Email" with "ericn@berkeley.edu"
  Then I press the add user symbol
  And I fill in "First Name" with "Yannie"
  And I fill in "Last Name" with "Yip"
  And I fill in "Email" with "yannie.yip@berkeley.edu"
  When I press "Save"
  Then I should see "Confirmation emails sent to users with account information."
  
  
  
  