Feature: Insights
  As the workshift manager
  So that my job of assigning people to shifts is easier
  I want hints that tell me who the best candidates to assign a shift to are
  
  Background:
    Given I am signed in as the workshift manager:
    And I am on the workshift assignments page
    
    Scenario: I should see an insight of who is good for a shift
      A user "Bob Dylan" exists with the following category preference rankings:
        | category  | rank |
        | Cleaning  | 2    |
        | Dishes    | 1    |
        | Groceries | 3    |
      And the following checked in column "Monday" and row "9-10AM"
      Then I should see "Bob Dylan" as one of the choices for a "Wash breakfast dishes" workshift on "Monday"
    
    Scenario: I should not see bad person for the shift
      A user "Bob Dylan" exists with the following category preference rankings:
        | category  | rank |
        | Cleaning  | 2    |
        | Dishes    | 1    |
        | Groceries | 3    |
      And the following checked in column "Monday" and row "9-10AM"
      Then I should not see "Bob Dylan" as one of the choices for a "Get groceries" workshift on "Saturday"
      
  
    
