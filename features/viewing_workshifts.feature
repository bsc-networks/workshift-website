Feature: blah blah

    As blah
    So that blah
    I want to blah

Background: workshifts have been added to the database

    Given the following workshifts exist:
    | task       | description    | hours | people_needed | start_time | end_time |
    | Wash Pots  | wash the pots  | 1     | 2             | 3:00pm     | 7:00pm   |
    | Do Laundry | do the laundry | 1     | 1             | 12:00am    | 11:59pm  |
    | Sweep      | clean hallway  | 2     | 1             | 12:30pm    | 4:30pm   |
    | Groceries  | go to store    | 2     | 3             | 12:00pm    | 4:00pm   |

Scenario:
    Given I am logged in as an authenticated user
    When I am on the "workshifts" page
    Then I should see all of the workshifts
