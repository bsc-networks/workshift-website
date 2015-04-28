Feature: One off workshifts
  As a workshift manager
  So that I can give people extra shifts that aren't tied to the current system
  I want to be able create one off shifts that are already marked as completed
  
  Background: I am the workshift manager
    Given I am signed in as a workshift manager
    And I am on the new workshift page
    
  Scenario: I can create a new workshift and mark it as completed
    When I fill in: 
      | field         | value              |
      | Task          | asdf               |
      | Hours         | 1                  |
      | StartTime     | 7:00 PM            |
      | EndTime       | 11:00 PM           |
      | Description   | take out the trash |
    And I check "Wednesday"
    And I choose the workshifter
    And I check "Already completed"
    And I press "Create Workshift"
    Then I should see in the workshifter's "History of Workshift Assignments" of the workshifter's page:
      | Day           | Wednesday           |
      | Task          | take out the trash  |
      | Status        | Completed           |
      | Verifier      | Boss Man            |
      
    
      
