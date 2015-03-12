Feature: workshift manager create shifts
  As the workshift manager
  So that I can set up workshifts
  I want to be able to create the workshifts

  Background: I am the workshift manager
    Given I am a workshift manager with email "manager@example.com" and name "Test Manager"

  Scenario: I can get to the new workshift page
    Given I am on the workshifts page
    And I follow "New Workshift"
    Then I should be on the new workshift page

  Scenario: I can create a new workshift
    Given I am on the workshifts page
    And I follow "New Workshift"
    When I fill in:
      | field         | value              |
      | Task          | asdf               |
      | NumberNeeded  | 1                  |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   | take out the trash |
      | Day           | Wednesday          |
    And I press "Create Workshift"
    Then I should see:
      | field         | value              |
      | Task          | asdf               |
      | NumberNeeded  | 1                  |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   | take out the trash |
      | Day           | Wednesday          |

  Scenario: I must fill in all the fields when I create a workshift
    Given I am on the workshifts page
    And I follow "New Workshift"
    When I fill in:
      | field         | value              |
      | Task          | asdf               |
      | NumberNeeded  |                    |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   |                    |
      | Day           | Wednesday          |
    And I press "Create Workshift"
    Then I should see an error message: "Please review the problems below:"

  Scenario: The start and end times don't correspond
    Given I am on the workshifts page
    And I follow "New Workshift"
    When I fill in:
      | field         | value              |
      | Task          | asdf               |
      | NumberNeeded  | 1                  |
      | Hours         | 1                  |
      | StartTime     | 11:00 PM           |
      | EndTime       | 10:00 PM           |
      | Description   | hi                 |
      | Day           | Wednesday          |
    And I press "Create Workshift"
    Then I should see an error message: "Please review the problems below:"

