Feature: workshift manager assign shifts
  As the workshift manager
  So that I can manage who is assigned to which shift
  I want to be able to assign users to workshifts

  Background: I am the workshift manager
    Given I am signed in as a workshift manager
    And I am on the workshifts page
    And the following workshifts exist:
      | task        | description     | day | hours | start_time | end_time |
      | Wash Pots   | wash the pots   | 0   | 1     | 15:00      | 19:00    |
      | Clean Floor | clean the floor | 2   | 1     | 11:00am    | 2:00pm   |
    And the following residents exist:
      | name        | email             | password |
      | Sally       | sally@example.com | secret   |
      | John        | john@example.com  | secret   |

  Scenario: I can assign a user to a workshift
    When I assign "Sally" to the workshift "Wash Pots"
    And I go to Sally's profile page
    Then I should see "Wash Pots"