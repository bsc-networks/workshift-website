Feature: Viewing all workshifts
  As a resident of the coop
  So that I can see what workshifts are available
  I want to navigate to the workshifts page and see them all

  Background: workshifts have been added to the database
    Given the following workshifts exist:
      | task       | description    | day | hours | start_time | end_time |
      | Wash Pots  | wash the pots  | 0   | 1     | 3:00pm     | 7:00pm   |
      | Do Laundry | do the laundry | 1   | 1     | 12:00am    | 11:59pm  |
      | Sweep      | clean hallway  | 2   | 2     | 12:30pm    | 4:30pm   |
      | Groceries  | go to store    | 3   | 2     | 12:00pm    | 4:00pm   |

  Scenario:
    Given I am signed in as a resident
    When I am on the workshifts page
    Then I should see all of the workshifts
