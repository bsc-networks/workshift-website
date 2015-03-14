Feature: Ordinary co-op residents shouldn't be able to change workshifts
  As the workshift manager
  So that residents don't interfere with my duties
  I want residents to not be able to tamper with workshifts

  Background: I am an ordinary resident with no admin privileges
    Given I am signed in as an authenticated user
    Given the following workshifts exist:
    | task       | description    | day | hours | people_needed | start_time | end_time |
    | Wash Pots  | wash the pots  | 0   | 1     | 2             | 3:00pm     | 7:00pm   |
    | Do Laundry | do the laundry | 1   | 1     | 1             | 12:00am    | 11:59pm  |
    | Sweep      | clean hallway  | 2   | 2     | 1             | 12:30pm    | 4:30pm   |
    | Groceries  | go to store    | 3   | 2     | 3             | 12:00pm    | 4:00pm   |

  Scenario: Cannot edit workshifts
    Given I am on the workshifts page
    Then I should not see any "Edit" links

  Scenario: Cannot delete workshifts
    Given I am on the workshifts page
    Then I should not see any "Destroy" links

  Scenario: Cannot create new workshifts
    Given I am on the workshifts page
    Then I should not see any "New Workshift" links
