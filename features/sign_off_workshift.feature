Feature: residents can mark workshifts as completed, and then be verified by
  another resident

  As a resident
  So that I can let everyone know that I've completed a workshift
  I want to be able to check off a workshift as completed with the
  verification of another resident

  Background:
    Given I am signed in as a resident
    And I am a resident named "Bobby Gee"
    And the shift "Wash the dishes" exists
    And I am assigned to the shift "Wash the dishes"

  Scenario: I mark the shift as complete
    When I mark the shift "Wash the dishes" as completed
    Then the status of the workshift should be "unconfirmed"

  Scenario: I choose someone to verify my completed shift
    When I mark the shift "Wash the dishes" as completed
    And I choose "Bobby Gee" to verify it
    Then the verifier should receive a request to verify the workshift
    And the status of the workshift should be "awaiting verification"

  Scenario: my verifier confirms I completed the shift
    Given I mark the shift "Wash the dishes" as completed
    And I choose "Bobby Gee" to verify it
    When the verifier confirms the workshift was completed
    Then the status of the workshift should be "completed"

  Scenario: my verifier refuses to verify the shift
    Given I mark the shift "Wash the dishes" as completed
    And I choose "Bobby Gee" to verify it
    When the verifier denies that the workshift was completed
    Then the status of the workshift should be "unconfirmed"
