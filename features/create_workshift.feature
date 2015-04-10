Feature: workshift manager create shifts
  As the workshift manager
  So that I can set up workshifts
  I want to be able to create new workshifts

  Background: I am the workshift manager
    Given I am signed in as a workshift manager
    And I am on the new workshift page

  Scenario: I can create a new workshift
    When I fill in:
      | field         | value              |
      | Task          | asdf               |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   | take out the trash |
    And I check "Wednesday"
    And I press "Create Workshift"
    Then I should see:
      | field         | value              |
      | Task          | asdf               |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   | take out the trash |
      | Day           | Wednesday          |

  Scenario: I must fill in all the fields when I create a workshift
    When I fill in:
      | field         | value              |
      | Task          | asdf               |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   |                    |
    And I check "Wednesday"
    And I press "Create Workshift"
    Then I should see an error message: "Please review the problems below:"