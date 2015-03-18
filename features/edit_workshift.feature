Feature: edit workshift
  As the workshift manager,
  In order to organize workshifts among students,
  I want to edit a workshift, including its hours, tasks, and number of people needed.

  Background: workshifts have been added to the database and I'm a signed in manager
    Given the following workshifts exist:
      | task       | description    | day | hours | start_time | end_time |
      | Wash Pots  | wash the pots  | 0   | 1     | 3:00pm     | 7:00pm   |
    And I am signed in as a workshift manager
    And I am on the edit page for workshift "Wash Pots"

  Scenario: Fill in the forms and see changes
    When I fill in:
      | field                 | value            |
      | Task                  | Eat Eyeballs     |
      | Hours                 | 4                |
      | StartTime             | 11:15 AM         |
      | Description           | What             |
    And I press "Update Workshift"
    Then I should see:
      | field                 | value            |
      | Task                  | Eat Eyeballs     |
      | Hours                 | 4                |
      | StartTime             | 11:15 AM         |
      | Description           | What             |
    But I should still see:
      | field                 | value            |
      | EndTime               | 7:00 PM          |

  Scenario: The start and end times don't correspond
    When I fill in:
      | field                 | value            |
      | Task                  | Eat Eyeballs     |
      | Hours                 | 4                |
      | StartTime             | 11:15 AM         |
      | EndTime               | 11:00 AM         |
      | Description           | What             |
    And I press "Update Workshift"
    Then I should see an error message: "Please review the problems below:"

  Scenario: Fill in the forms with blank required fields
    When I fill in:
      | field                 | value            |
      | Task                  |                  |
    And I press "Update Workshift"
    Then I should see an error message: "Please review the problems below:"
