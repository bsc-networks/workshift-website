Feature: workshift manager can create accounts for new residents
  As the workshift manager
  So that residents can log in and view their shifts
  I want to be able to enter comma-separated values into a textbox with names
  in one column and emails in another to create accounts for each of the house
  residents

  Background:
    Given I am signed in as a workshift manager
    And I am on the Add Users page

  Scenario: looks at each row of the inputted text to create new accounts
    When I try to invite the following users:
      | User 1,user_1@example.com |
      | User 2,user_2@example.com |
      | User 3,user_3@example.com |
    Then 3 new users should have been invited

  Scenario: gives an error when empty input entered
    When I try to invite the following users:
      | |
    Then I should see "Must input at least one user"

  Scenario: gives an error when incorrectly formatted input entered
    When I try to invite the following users:
      | User 1,user_1@example.com |
      | User 2 |
      | User3,user_3@example.com |
    Then I should see "Improperly formatted user information on row 2"
