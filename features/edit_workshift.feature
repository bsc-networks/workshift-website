Feature: edit workshift
  As the workshift manager,
  In order to organize workshifts among students,
  I want to edit a workshift, including its hours, tasks, and number of people needed.

Background: workshifts have been added to the database and I'm a signed in manager
    Given the following workshifts exist:
    | task       | description    | day | hours | people_needed | start_time | end_time |
    | Wash Pots  | wash the pots  | 0   | 1     | 2             | 3:00pm     | 7:00pm   |
    | Do Laundry | do the laundry | 1   | 1     | 1             | 12:00am    | 11:59pm  |
    | Sweep      | clean hallway  | 2   | 2     | 1             | 12:30pm    | 4:30pm   |
    | Groceries  | go to store    | 3   | 2     | 3             | 12:00pm    | 4:00pm   |
    And I am a workshift manager with email "manager@example.com" and name "Test Manager"

Scenario: See the edit page
  Given I am on the workshifts page
  When I click on "Edit" for the task "Wash Pots"
  Then the manager should be on the edit page for "Wash Pots"

Scenario: Fill in the forms and see changes
  Given the manager is on the edit page for "Wash Pots"
  When I fill in:
    | field                 | value            |
    | Task                  | Eat Eyeballs     |
    | NumberNeeded          | 5                |
    | Hours                 | 4                |
    | StartTime             | 11 AM            |
    | Description           | What             |
  When I click on the "Update Workshift" button
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
  Given the manager is on the edit page for "Wash Pots"
  When I fill in:
    | field                 | value            |
    | Task                  |                  |
    | NumberNeeded          |                  |
  And I click on the "Update Workshift" button
  Then I should see an error message: "Please review the problems below:"

