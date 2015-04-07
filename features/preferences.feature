Feature: residents can list preferences of workshifts through categories
  As the resident
  So that I can help choose my workshift assignments
  I want to be able to rank my preferences of categories

  Background:
    Given I am signed in as a resident
    And the following categories exist:
      | name       |
      | Cleaning   |
      | Dishes     |
      | Groceries  |
    And I am on the user preferences page
    And I have no category preferences

  Scenario: ranking preferences for the first time
    When I rank the "Cleaning" category 1
    And I rank the "Dishes" category 2
    And I rank the "Groceries" category 3
    And I press "Update Category Preferences"
    Then my category preference rankings should be:
      | category  | rank |
      | Cleaning  | 1    |
      | Dishes    | 2    |
      | Groceries | 3    |

  Scenario: updating preferences
    Given I have the following category preferences:
      | category  | rank |
      | Cleaning  | 1    |
      | Dishes    | 2    |
      | Groceries | 3    |
    When I rank the "Cleaning" category 3
    And I rank the "Dishes" category 1
    And I rank the "Groceries" category 2
    And I press "Update Category Preferences"
    Then my category preference rankings should be:
      | category  | rank |
      | Cleaning  | 3    |
      | Dishes    | 1    |
      | Groceries | 2    |

  Scenario: input rejected if fail to rank a category
    When I rank the "Cleaning" category 1
    And I rank the "Groceries" category 2
    And I press "Update Category Preferences"
    Then I should see "No rank selected for category Dishes"

  Scenario: input rejected if multiple categories given the same ranking
    When I rank the "Cleaning" category 1
    And I rank the "Dishes" category 2
    And I rank the "Groceries" category 2
    And I press "Update Category Preferences"
    Then I should see "Please select each ranking only once."
