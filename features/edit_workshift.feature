Feature: edit workshift
  As a workshift manager,
  In order to organize workshifts among students,
  I want to edit a workshift, including its hours, tasks, and number of people needed.

Scenario: See the edit page
  Given I am a workshift manager
  And the following workshifts exist:
    | Name                         | Hours         | Number of people |
    | Expedite Strategic Eyeballs  | 3             | 2                |
  And I am on the workshifts page
  When I click on "Edit" for the task "Expedite Strategic Eyeballs"
  Then I should be on the edit page for "Expedite Strategic Eyeballs"

Scenario: Fill in the forms and see changes
  Given I am a workshift manager
  And the following workshifts exist:
    | Name                         | Hours         | Number of people |
    | Expedite Strategic Eyeballs  | 3             | 2                |
  And I am on the workshifts page
  And I click on "Edit" for the task "Expedite Strategic Eyeballs"
  Then I should be on the edit page for "Expedite Strategic Eyeballs"

Scenario: Fill in the forms and see changes
  Given I am a workshift manager
  And the following workshifts exist:
    | Name                         | Hours         | Number of people |
    | Expedite Strategic Eyeballs  | 3             | 2                |
  And I am on the edit page for "Expedite Strategic Eyeballs"
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
  Given I am a workshift manager
  And the following workshifts exist:
    | Name                         | Hours         | Number of people |
    | Expedite Strategic Eyeballs  | 3             | 2                |
  And I am on the edit page for "Expedite Strategic Eyeballs"
  When I fill in:
    | field                 | value            |
    | Task                  |                  |
    | Number needed         |                  |
  And I click the "Update Workshift" button
  Then I should see an error page: "Invalid fields"

