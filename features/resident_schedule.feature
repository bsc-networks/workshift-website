Feature: Residents can show their schedule
 As the resident
 So that I can show others what workshifts I can do
 I want to be able to show when I'm free

  Background:
    Given I am a resident
    Given I am on the user settings page

  Scenario: I can edit a schedule
    When I fill in:
      | day           | free?              | hour        |
      | Monday        | Yes                | 9:00AM      |
    And I press "Update Schdule"
    Then I should see:
      | day           | free?              | hour        |
      | Monday        | Yes                | 9:00AM      |
