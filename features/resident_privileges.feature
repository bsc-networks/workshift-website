Feature: Ordinary residents can't change workshifts
  As the workshift manager
  So that residents don't interfere with my duties
  I want residents to not be able to tamper with workshifts

  Background: I am an ordinary resident with no admin privileges
    Given I am signed in as a resident
    And the workshift "Groceries" exists

  Scenario: I cannot edit existing workshifts
    When I go to the edit page for workshift "Groceries"
    Then I should be on the home page
    And I should see "You are not authorized to edit workshifts."

  Scenario: I cannot delete existing workshifts
    When I am on the view page for workshift "Groceries"
    Then I should not see "Destroy"

  Scenario: I cannot create new workshifts
    When I go to the new workshift page
    Then I should be on the home page
    And I should see "You are not authorized to create new workshifts."
