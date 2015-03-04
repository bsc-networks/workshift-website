Feature: display list of all residents

Background: residents have been added to database

  Given the following residents exist:
  | name                    | email                |  
  | Timmy Turner            | example@example.com  | 
  | Dev Patel               | example@example.com  | 
  | Cady Haring             | example@example.com  | 
  | Janice Ian              | example@example.com  | 
  | Tina Fey                | example@example.com  | 
  | Vincent Wong            | example@example.com  | 
  | Stephanie Kim           | example@example.com  |
  | Pam Beasley             | example@example.com  |
  | Michael Scott           | example@example.com  | 
  | Dwight Schrute          | example@example.com  |

  And I am on the Roster page

Scenario: all residents' names are displayed and sorted alphabetically
  I should see all of the residents
  And I should see "Dev Patel" before "Timmy Turner"
  And I should see "Dwight Schrute" before "Michael Scott"
  