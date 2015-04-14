Feature: workshift manager can group workshift assignments by category
  As the workshift manager
  So that I can organize workshift assignments more easily
  I want to be able to create and modify categories of workshifts

  Background:
    Given I am signed in as a workshift manager

  Scenario: I can create a new category
    When I go to the new category page
    And I fill in:
      | field         | value              |
      | Name          | Dishes             |
    And I press "Create Category"
    Then there should be a category with name "Dishes"

  Scenario: I can edit a category
    Given the category "Cleaning" exists
    When I go to the edit page for category "Cleaning"
    And I fill in:
      | field         | value              |
      | Name          | Groceries          |
    And I press "Update Category"
    Then there should be a category with name "Groceries"

  Scenario: Fill in the forms with blank required fields
    When I go to the new category page
    And I press "Create Category"
    Then I should see an error message: "Please review the problems below:"

  Scenario: workshifts can be assigned to categories
    Given the category "Dishes" exists
    And the workshift "Wash the pots" exists
    And it belongs to the category "Dishes"
    When I am on the view page for category "Dishes"
    Then I should see "Wash the pots"
