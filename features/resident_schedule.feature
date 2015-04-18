Feature: Residents can show their schedule
 As the resident
 So that I can show others what workshifts I can do
 I want to be able to show when I'm free

  Background:
    Given I am signed in as a resident
    And I am on the user preferences page

  Scenario: I can edit a schedule
    When I check the box in column "Monday" and row "9-10AM"
    And I press "Update Schedule"
    And I go to the user preferences page
    Then the box in column "Monday" and row "9-10AM" should be checked
