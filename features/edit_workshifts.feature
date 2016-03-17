Feature: Edit a Workshift
  As a work-shift manager,
  In order to keep workshift information up-to-date,
  I would like to view and edit workshift attributes.
  
  Background:
    Given I am logged in as a workshift manager
    And PENDING I have created workshifts for the semester
    And I go to the view workshifts page
  
  Scenario: An admin views workshifts for the semester 
    Then I should see "Workshifts"
    And I should see a table
    
  Scenario: An admin edits a workshift
    And I follow "Edit" for "Sweep Floors"
    Then I should be on the edit workshift page
    And I should see "Sweep Floors"
    When I fill in "Hour Value" with "3"
    And I press "Save Changes"
    Then I should be on the view workshifts page
    And I should see "Your workshift has been updated."
    And I should see "3" in the row for "Sweep Floors"
 
  