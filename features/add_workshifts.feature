Feature: Adding workshifts
    As a work-shift manager
    I want to be able to upload workshifts at the start of the semester
    To make sure the coop's responsibilities are fulfilled
    
Background:
  Given I am logged in as a workshift manager
  And I go to the create workshifts page

Scenario: an admin adds workshifts using a csv file
  When I upload "workshifts_upload.csv"
  Then I press "Import"
  Then I should see a workshift table
  And I should see "Clean" "2" times
  And I should see "Plant" "1" times
  Then I should see "You added 3 new workshifts"
  
Scenario: an admin adds workshifts manually
  And I fill in "Category" with "Kitchen"
  And I fill in "Description" with "Sweeping the kitchen floor"
  And I fill in "Hour Value" with "1.5"
  When I press "Add Workshift"
  Then I should see "You added 1 new workshifts"
  
Scenario: an admin edits a table entry
  When I upload "workshifts_upload.csv"
  Then I press "Import"
  And I follow "Edit"
  Then I should be on the edit workshifts page
  
Scenario: an admin tries to import no file
  When I press "Import"
  Then I should be on the create workshifts page