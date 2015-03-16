Feature: display list of all residents

  Background: residents have been added to database

    Given the following residents exist:
      | name                    | email                |
      | Timmy Turner            | example_1@example.com  |
      | Dev Patel               | example_2@example.com  |
      | Cady Haring             | example_3@example.com  |
      | Janice Ian              | example_4@example.com  |
      | Tina Fey                | example_5@example.com  |
      | Vincent Wong            | example_6@example.com  |
      | Stephanie Kim           | example_7@example.com  |
      | Pam Beasley             | example_8@example.com  |
      | Michael Scott           | example_9@example.com  |
      | Dwight Schrute          | example_0@example.com  |
    And I am on the roster page

  Scenario: all residents' names are displayed
