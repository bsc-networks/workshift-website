Feature: delete all current residents from database
  As the workshift manager
  So that I can clear the house roster before the start of a new semester
  I want to be able to click a button to remove all residents from the database.

  Background: I am the workshift manager
    Given I am signed in as a workshift manager
    And I am on the settings page

  Scenario: there is a button to remove all residents
    Then I should see "Delete All Residents"

  Scenario: after clicking the button only I remain in the database
    Given 30 residents exist
    When I follow "Delete All Residents"
    Then only 1 person is left in the database
