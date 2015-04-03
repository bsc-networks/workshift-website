Feature: workshift manager can group workshift assignments by category
  As the workshift manager
  So that I can organize workshift assignments more easily
  I want to be able to create and modify categories of workshifts

  Background:
    Given I am signed in as a workshift manager
    And the following workshifts exist:
      | task       | description    | day | hours | start_time | end_time |
      | Wash Pots  | wash the pots  | 0   | 1     | 3:00pm     | 7:00pm   |

  Scenario: I can create a new category
    When I go to the categories page
    And I follow "New Category"
    And I fill in the following for a category:
      | field         | value              |
      | Name          | asdf               |
    And I press "Create Category"
    Then I should see the following for a category:
      | field         | value              |
      | Name          | asdf               |

  Scenario: I can edit a category
    Given the following categories exist:
      | name       | 
      | Cleaning   | 
    When I go to the categories page
    And I follow "Cleaning"
    And I follow "Edit"
    And I fill in the following for a category:
      | field         | value              |
      | Name          | Shopping           |
    And I press "Update Category"
    Then I should see the following for a category:
      | field         | value              |
      | Name          | Shopping           |

  Scenario: Fill in the forms with blank required fields
    When I go to the categories page
    And I follow "New Category"
    And I press "Create Category"
    Then I should see an error message: "Please review the problems below:"
