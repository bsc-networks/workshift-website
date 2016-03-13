Feature: Editing Semester Policies
  As a work-shift manager,
  In order to enforce policies for the semester,
  I would like to view and edit fining dates, the start and end of the semester, market sell-by, and fining rates.
  
  Background:
    Given I am logged in as an admin
    And I have set the policies for the semester
  
  Scenario: An admin views the policies for the semester 
    When I go to the view policy page
    Then I should see "Your Policies"
    And I should see "Semester Start Date:" 
    And I should see "2016-01-16"
    And I should see "Edit"
    
  Scenario: An admin edits the policies for the semester
    When I go to the view policy page
    And I follow "Edit"
    Then I should be on the edit policies page
    When  I fill in "Fine rate" with "100"
    And  I press "Save Changes"
    Then I should be on the view policy page
    And I should see "Your policies have been updated"
    And I should see "100"
 
  