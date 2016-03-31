Feature: Viewing Semester Policies
  As a coop member,
  In order to abide by the policies for the semester,
  I would like to view fining dates, the start and end of the semester, market sell-by, and fining rates.
  
  Background:
    Given I am logged in as a non-admin
  
  Scenario: A member tries to view nonexistent policies for the semester 
    When I go to the view policy page
    Then I should be on the home page
    And I should see "The policies have not been set for this semester"
    
  Scenario: A member views the policies for the semester
    Given the policies for the semester have been set
    When I go to the view policy page
    Then I should see "Your Policies"
    And I should see "Semester Start Date:" 
    And I should see "January 16, 2016"
    And I should not see "Edit"
  