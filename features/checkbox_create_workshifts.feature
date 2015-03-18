Feature: checkbox create workshifts
	As a workshift manager
	So that I can sort the workshifts by day
	I want to be able to create a new shift every time it's checked on the checkboxes field

  Background: I am the workshift manager
    Given I am signed in as a workshift manager
    And I am on the new workshift page

  Scenario: I can create a new workshift for each day that it's checked
    When I fill in:
      | field         | value              |
      | Task          | asdf               |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   | take out the trash |
    And I check "Monday" of the "Day(s)" checkboxes
    And I check "Tuesday" of the "Day(s)"checkboxes
    And I press "Create Workshift"
    Then I should see:
      | field         | value              |
      | Task          | asdf               |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   | take out the trash |
      | Day(s)        | Monday, Tuesday    |

  Scenario: Nothing was checked
    When I fill in:
        | field         | value              |
        | Task          | asdf               |
        | Hours         | 1                  |
        | StartTime     | 7:00 PM            |
        | EndTime       | 11:00 PM           |
        | Description   | take out the trash |
      And I press "Create Workshift"
      Then I should see an error message: "Please select which day(s) to create the shift for"

