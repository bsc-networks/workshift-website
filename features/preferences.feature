Feature: residents can list preferences of workshifts through categories
  As the resident
  So that I can help choose my workshift assignments
  I want to be able to rank my preferences of categories

  Background:
    Given I am a resident
    Given that the following categories exist:
      | name          | description        |
      | Clean         | clean related      |
      | Dishes        | dishes related     |
      | Shop          | shopping related   |
    Given I am on the user settings page

  Scenario: I can rank preferences
    When I fill in "1" for the "Clean" category
    And I fill in "2" for the "Dishes" category
    And I fill in "3" for the "Shop" category
    And I press submit
    Then I should see:
      | name          | rank        |
      | Clean         | 1           |
      | Dishes        | 2           |
      | Shop          | 3           |
    When I fill in "2" for the "Clean" category
    And I fill in "3" for the "Dishes" category
    And I fill in "1" for the "Shop" category
    And I press submit
    Then I should see:
      | name          | rank        |
      | Clean         | 2           |
      | Dishes        | 3           |
      | Shop          | 1           |
