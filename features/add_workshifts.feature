Feature: Adding workshifts
    As a workshift manager,
    In order to set the types of shifts that my house needs completed,
    I would like to be able to upload a CSV file with the workshift information.
    
Background:
  Given I am logged in as a workshift manager
  And I go to the create workshifts page

Scenario: an admin adds workshifts using a csv file
  When I upload "workshifts_upload.csv"
  And I press "Import"
  Then I should see a workshift table
  And I should see "Clean" "2" times
  And I should see "Plant" "1" times
  And I should see "You added 3 new workshifts"
  
Scenario: an admin adds workshifts manually
  When I fill in "Category" with "Kitchen"
  # And I fill in "Name" with "Sweep"
  And I fill in "Description" with "Sweeping the kitchen floor"
  And I fill in "Hour Value" with "1.5"
  When I press "Add Workshift"
  Then I should see "You added 1 new workshifts"
  
Scenario: an admin edits a table entry
  When I upload "workshifts_upload.csv"
  And I press "Import"
  # When I click "Edit"
  # Then I should be on the edit workshifts page
  # Then I should be able to edit the values for the table entry
  
Scenario: an admin tries to import no file
  When I press "Import"
  Then I should be on the create workshifts page
  # And I should see "You must select a file to upload."