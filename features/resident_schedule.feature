Feature: residents can show their schedule
  As the resident
  So that I can show others what workshifts I can do
  I want to be able to show and edit my schedule

  Background:
    Given I am a resident
    Given I am on the user settings page

  Scenario: I can edit a schedule
    When I fill in:
      | name          | description        | start time  | end time |
      | Monday        | Busy               | 9:00AM      | 10:00AM  |
      | Description   | dishes related     | 11:00AM     | 11:30AM  |
    And I press "Update Schdule"
    Then I should see:
      | name          | description        | start time  | end time |
      | Monday        | Busy               | 9:00AM      | 10:00AM  |
      | Description   | dishes related     | 11:00AM     | 11:30AM  |
