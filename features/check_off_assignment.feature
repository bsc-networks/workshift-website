Feature: Residents can mark workshifts as completed
  As a resident
  So that I can let everyone know that I've completed a workshift
  I want to be able to check off a workshift with the verification of another resident

  Background:
    Given I am signed in as a resident named "Alice Carol"
    And a resident named "Bobby Gee" exists
    And the shift "Wash the dishes" exists
    And I am assigned to the shift "Wash the dishes"
    And I am on my profile page

   Scenario: I try to check off the shift before it starts
  #   Given my assignment has not started yet
  #   And I check off my assignment as completed with verifier "Bobby Gee"
  #   Then my assignment should still be "upcoming"

  # Scenario: I try to check off the shift with myself as verifier
  #   Given my assignment is awaiting check off
  #   And I check off my assignment as completed with verifier "Alice Carol"
  #   Then my assignment should still be "upcoming"

  # Scenario: I check off the shift as completed with valid verifier
  #   Given my assignment is awaiting check off
  #   And I check off my assignment as commpleted with verifier "Bobby Gee"
  #   Then my assignment should be "complete"
