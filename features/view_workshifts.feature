Feature: View a Workshift
  As a user of any type,
  In order to learn more about a workshift,
  I would like to view the list of workshifts and select one to see more details.
  
  Background:
    Given I am logged in as a user
    And some workshifts have been created for the semester
    And I am on the view workshifts page
  
  Scenario: A regular user can see all workshift slots for the semester
    Then I should see "Listing Shifts"
    # And I should see a table
    And I should see "Description"
    And I should see "Members Assigned"
    And I should see "Maura Fitz" in the row for "Sweep Floors"

 Scenario: A regular user can't edit workshifts
    Then I should see "Listing Shifts"
    And I should not see "Edit"
 
  