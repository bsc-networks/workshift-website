Feature: Adding Workshifts

    As a work-shift manager
    I want to be able to upload a csv file with all my workshifts
    To ease the process of creating workshifts

Background:
  Given I am on the add workshifts page
  Given none of the workshifts exists
  
Scenario: an admin tries to add workshifts using a csv file
  When I upload "workshift_upload.csv"
  Then I press "Import"
  Then I should see a table
  And I should see "Dishes"
  And I should see "3:00 pm"
  When I press "Confirm Workshifts"
  Then I should be on the workshift page
  And I should see "Dishes"
  
