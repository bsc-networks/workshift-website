Feature: Workshift Marketplace
  As a resident
  So that I can give away workshift assignments that I cannot complete
  And so that I can earn extra points by taking up shifts that others can't complete
  I want to be able to sell and buy shifts on the workshift marketplace

  Background: Selling a shift before 24 hour 'deadline'
    Given I am assigned to the following shift:
      | task   | description  | day | hours | start_time | end_time |
      | Dishes | clean dishes | 0   | 1     | 11:00am    | 1:30pm   |
    Given there is more than 24 hours until my shift starts
    And I sell my shift

  Scenario: I put my workshift on the market
    Given I put my workshift on the market
    Then I can see my workshift on the marketplace

  Scenario: Someone buys my shift
    Given someone buys shift
    Then I should only lose the shift's hours number of points

  Scenario: No one buys my shift
    Given no one buys my shift and the workshift has passed
    Then I should only lose the shift's hours number of points

  Scenario: I undo the selling of my shift
    Given no one buys my shift and the workshift has not started yet
    And I click "undo"
    Then I should not see my workshift in the Marketplace

  Scenario: I sell my shift
    Given my shift has not started yet
    And I click "sell"
    Then I should see my workshift in the Marketplace

