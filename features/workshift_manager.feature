Feature: workshift manager edit shifts
  As the workshift manager
  So that I can set up workshifts
  I want to be able to edit the workshifts

  Background: I am the workshift manager
    Given I am a workshift manager with email "manager@example.com" and name "Test Manager"

  Scenario: Create a workshift
    Given I am on the workshifts listing page
    And I follow "New Workshift"
    Then I should be on the new workshift page
    And I fill in the following:
      | Task          | Take out the trash |
      | Number needed | 1                  |
      | Hours         | 1                  |
      | Start time    | 11 PM, 00          |
      | End time      | 12 PM, 00          |
      | Description   | take out the trash |
      | Day           | Wednesday          |
    And I press "Create Workshift"
    Then I should see the workshift "asdf"

  Scenario: Delete a workshift
    Given TO DO

