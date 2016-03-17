Feature: Adding workshifts
    
    As a work-shift manager
    I want to be able to upload workshifts at the start of the semester
    To make sure the coop's responsibilities are fulfilled
    
Background:
  Given I am logged in as a workshift manager
  And PENDING I go to the create workshifts page

Scenario: an admin adds workshifts using a csv file
  When PENDING I upload "workshifts_upload.csv"
  Then I press "Import"
  Then I should see a table
  And I should see "Clean dishes" "2" times
  And I should see "Washing and drying dishes" "2" times
  And "Clean dishes" should have day "Wednesday" with hours "01:00PM" to "03:00PM" 
  And "Clean dishes" should have category "Kitchen" with hour value "1"
  When I press "Confirm Workshifts"
  Then I should see "Workshifts created."
  
Scenario: an admin adds workshifts manually
  And I fill in "Name" with "Sweep kitchen"
  And I fill in "Category" with "Kitchen"
  And I fill in "Description" with "Sweeping the kitchen floor"
  And I fill in "Hour value" with "1.5"
  When I press "Add Workshift"
  When I press "Confirm Workshifts"
  Then I should see "Workshifts created."
  
Scenario: an admin edits a table entry
  When I upload "workshifts_upload.csv"
  Then I press "Import"
  And I follow "Edit"
  Then I should be on the edit workshifts page
  
Scenario: an admin tries to import no file
  When I press "Import"
  Then I should be on the create workshifts page