Feature: workshift manager create shifts
  As the workshift manager
  So that I can organize workshifts
  I want to be able to delete the workshifts

  Background: I am the workshift manager and some workshifts exist
    Given the following workshifts exist:
    | task       | description    | day | hours | people_needed | start_time | end_time |
    | Wash Pots  | wash the pots  | 0   | 1     | 2             | 3:00pm     | 7:00pm   |
    | Do Laundry | do the laundry | 1   | 1     | 1             | 12:00am    | 11:59pm  |
    | Sweep      | clean hallway  | 2   | 2     | 1             | 12:30pm    | 4:30pm   |
    | Groceries  | go to store    | 3   | 2     | 3             | 12:00pm    | 4:00pm   |
    Given I am a workshift manager with email "manager@example.com" and name "Test Manager"

  Scenario: I can delete a workshift
    Given I am on the workshifts page
    Then I should be able to click on "Destroy" for the task "Groceries"

