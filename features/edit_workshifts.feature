Feature: Edit a Workshift
  As a work-shift manager,
  In order to keep workshift information up-to-date,
  I would like to view and edit workshift attributes.
  
  Background:
    Given the following workshifts exist:
    | category      | name                             | hour | description                                   |
    | Kitchen       | Kitchen Manager                  | 4    | Refer to bylaws for manager description.      |
    | Kitchen       | Dishes                           | 2    | Use a sponge and soap to scrub off each dish. |
    | Kitchen       | Head Cook                        | 3    | Lead a team in cooking meals.                 |
    | Garbage       | Waste Reduction Coordinator      | 3    | Coordinate waste reduction. Go to CO.         |
    | Garbage       | TRC (Trash, Recycling, Compost)  | 1    | Take out trash, recycling and compost bins.   |
    And I am on the view workshifts page
  
  # @wip
  Scenario: A member views workshifts for the semester but cannot edit
    Given I am logged in as a member
    Then I should see "All Workshifts"
    And I should see a workshift table
    And I should see "Kitchen" "3" times
    And I should see "Garbage" "2" times
    And I should see the following: "Kitchen Manager", "Dishes", "Head Cook", "Waste Reduction", "TRC"
    And I should see the following: "4", "2", "3", "1"
    And I should see "Lead a team in cooking meals."
    And I should see "Use a sponge and soap to scrub off each dish."
    And I should not see "Edit"
    
  # @wip  
  Scenario: An admin edits a workshift
    Given I am logged in as an admin
    When I follow "Edit" for "Head Cook"
    Then I should be on the edit workshift page
    And I should see "Head Cook"
    When I fill in "Hour Value" with "5"
    And I press "Save Changes"
    Then I should be on the view workshifts page
    And I should see "Your workshift has been updated."
    And I should see "5" in the row for "Head Cook"
    
  # @wip
  Scenario: An admin tries to edit a workshift incorrectly
    Given I am logged in as an admin
    When I follow "Edit" for "Head Cook"
    When I fill in "Name" with ""
    And I press "Save Changes"
    Then I should be on the edit workshift page
    And I should see "Your edits are not valid."
 
  