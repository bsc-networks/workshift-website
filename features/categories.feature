Feature: workshift manager can group workshift assignments by category
  As the workshift manager
  So that I can organize workshift assignments more easily
  I want to be able to create and modify categories of workshifts

  Background:
    Given I am a workshift manager

  Scenario: I can create a new category
    When I go to the create category page
    And I fill in:
      | field         | value              |
      | Name          | asdf               |
      | Description   | dishes related     |
    And I press "Create Category"
    Then I should see:
      | field         | value              |
      | Name          | asdf               |
      | Description   | dishes related     |

  Scenario: I can edit a category
    Given that a category called "asdf" exists
    When I go to the category page for "asdf"
    And I fill in:
      | field         | value              |
      | Name          | dishes             |
      | Description   | dishes related     |
    And I press "Submit Changes"
    Then I should see:
      | field         | value              |
      | Name          | dishes             |
      | Description   | dishes related     |

  Scenario: I can delete a category
    Given that a category called "asdf" exists
    When I go to categories page
    And click on "Delete" for the category "asdf"
    Then I should not see "asdf"
