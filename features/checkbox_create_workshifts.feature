Feature: checkbox create workshifts
  As a workshift manager
  So that I can create duplicate workshifts for jobs that happen on multiple days
  I want to be able to have a new shift be created every time it's checked on the checkboxes field

  Background: I am the workshift manager
    Given I am signed in as a workshift manager
    And I am on the new workshift page

  Scenario: I can create a new workshift for each day that it's checked
    When I fill in:
      | field         | value              |
      | Task          | Wash Dishes        |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   | take out the trash |
    And I check "Monday"
    And I check "Tuesday"
    And I check "Friday"
    And I press "Create Workshift"
    Then the "Wash Dishes" workshift should exist for the following days:
      | Monday  |
      | Tuesday |
      | Friday  |

  Scenario: Nothing was checked
    When I fill in:
      | field         | value              |
      | Task          | asdf               |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   | take out the trash |
    And I press "Create Workshift"
    Then I should see "Must select at least one day."
