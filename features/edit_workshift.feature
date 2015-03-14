Feature: edit workshift
  As the workshift manager,
  In order to organize workshifts among students,
  I want to edit a workshift, including its hours, tasks, and number of people needed.

  Background: workshifts have been added to the database and I'm a signed in manager
    Given the following workshifts exist:
      | task       | description    | day | hours | people_needed | start_time | end_time |
      | Wash Pots  | wash the pots  | 0   | 1     | 2             | 3:00pm     | 7:00pm   |
    And I am signed in as a workshift manager
    And I am on the edit page for workshift "Wash Pots"

  Scenario: Fill in the forms and see changes
    When I fill in:
      | field                 | value            |
      | Task                  | Eat Eyeballs     |
      | NumberNeeded          | 5                |
      | Hours                 | 4                |
      | StartTime             | 11 AM            |
      | Description           | What             |
    And I press "Update Workshift"
    Then I should see:
      | field                 | value            |
      | Task                  | Eat Eyeballs     |
      | NumberNeeded          | 5                |
      | Hours                 | 4                |
      | StartTime             | 11 AM            |
      | Description           | What             |
    But I should still see:
      | field                 | value            |
      | EndTime               | 07 PM            |

  Scenario: Fill in the forms with blank required fields
    When I fill in:
      | field                 | value            |
      | Task                  |                  |
      | NumberNeeded          |                  |
    And I press "Update Workshift"
    Then I should see an error message: "Please review the problems below:"
