Feature: Email Sign-off to verify completed shift
  As a resident
  So that I can verify my own completion of my shit
  I want an email to be sent automatically to my verifier for him/her to sign off on my shift

  Background: 
    Given I am signed in as a resident
    And a resident named "Britney Spears" exists
    And the shift "Clean the bathroom" exists
    And I am assignmented to the shift "Clean the bathroom"

  Scenario: my verifier receives the email and verifies the completed shift
    When I mark the shift "Clean the bathroom" as completed
    And I choose "Britney Spears" to verify it
    When the verifier confirms the workshift was completed
    Then the status of the worksift should be "completed"

  Scenario: my verifier hasn't responded to email 
    When I mark the shift "Clean the bathroom" as completed
    And I choose "Britney Spears" to verify it
    Then the status of the workshift should be "unconfirmed"
