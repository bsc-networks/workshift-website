Feature: display list of all residents

  Background: residents have been added to database

    Given the following residents exist:
      | name                    | email                  | password |
      | Timmy Turner            | example_1@example.com  | secret   |
      | Dev Patel               | example_2@example.com  | secret   |
      | Cady Haring             | example_3@example.com  | secret   |
      | Janice Ian              | example_4@example.com  | secret   |
      | Tina Fey                | example_5@example.com  | secret   |
      | Vincent Wong            | example_6@example.com  | secret   |
      | Stephanie Kim           | example_7@example.com  | secret   |
      | Pam Beasley             | example_8@example.com  | secret   |
      | Michael Scott           | example_9@example.com  | secret   |
      | Dwight Schrute          | example_0@example.com  | secret   |
    And I am on the roster page

  Scenario: all residents' names are displayed
