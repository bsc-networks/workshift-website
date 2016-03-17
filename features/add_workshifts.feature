<<<<<<< HEAD
Feature: Adding workshifts
    
    As a work-shift manager
    I want to be able to upload workshifts at the start of the semester
    To make sure the coop's responsibilities are fulfilled
    
Background:
  Given I am logged in as a workshift manager

Scenario: an admin adds workshifts using a csv file
  When I upload "workshifts_upload.csv"
  Then I press "Import"
  Then I should see a table
  And I should see "Clean dishes" "2" times
  And I should see "Washing and drying dishes" "2" times
  And "Clean dishes" should have day "Wednesday" with hours "1:00PM to 3:00PM"
  When I press "Confirm Workshifts"
  Then I should see "Workshifts created."
  
Scenario: an admin adds workshifts manually
