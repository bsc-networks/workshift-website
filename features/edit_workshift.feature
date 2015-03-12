Feature: edit workshift
  As the workshift manager,
  In order to organize workshifts among students,
  I want to edit a workshift, including its hours, tasks, and number of people needed.

Background: workshifts have been added to the database and I'm a manager
    Given I am a workshift manager with email "manager@example.com" and name "Test Manager"
    Given the following workshifts exist:
    | task       | description    | hours | people_needed | start_time | end_time |
    | Wash Pots  | wash the pots  | 1     | 2             | 3:00pm     | 7:00pm   |
    | Do Laundry | do the laundry | 1     | 1             | 12:00am    | 11:59pm  |
    | Sweep      | clean hallway  | 2     | 1             | 12:30pm    | 4:30pm   |
    | Groceries  | go to store    | 2     | 3             | 12:00pm    | 4:00pm   |

Scenario: See the edit page
  Given I am on the workshifts page
  When I click on "Edit" for the task "Wash Pots"
  Then I should be on the edit page for "Wash Pots"

Scenario: Fill in the forms and see changes
  Given I am on the workshifts listing page
  And I click on "Edit" for the task "Wash Pots"
  Then I should be on the edit page for "Wash Pots"

Scenario: Fill in the forms and see changes
  Given I am on the edit page for "Wash Pots"
  When I fill in:
    | field                 | value            |
    | Task                  | Eat Eyeballs     |
    | Number needed         | 5                |
    | Hours                 | 4                |
    | Start time            | 11 AM            |
    | Description           | What             |
  And I click the "Update Workshift" button
  Then I should see:
    | field                 | value            |
    | Task                  | Eat Eyeballs     |
    | Number needed         | 5                |
    | Hours                 | 4                |
    | Start time            | 11 AM            |
    | Description           | What             |

Scenario: Fill in the forms with blank required fields
  Given the following workshifts exist:
    | Name                         | Hours         | Number of people |
    | Wash Pots  | 3             | 2                |
  And I am on the edit page for "Wash Pots"
  When I fill in:
    | field                 | value            |
    | Task                  |                  |
    | Number needed         |                  |
  And I click the "Update Workshift" button
  Then I should see an error page: "Invalid fields"

