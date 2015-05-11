@clockwork
Feature: Workshift Marketplace
  As a resident
  So that I can give away workshift assignments that I cannot complete
  And so that I can earn extra points by taking up shifts that others can't complete
  I want to be able to sell and buy shifts on the workshift marketplace

  Background: Selling a shift before 24 hour 'deadline'
    Given I am signed in as a resident
    And I am assigned to the shift "Wash Dishes"

  Scenario: I put my workshift on the market before the 24 hour deadline
    When I put my workshift on the market before the deadline
    Then I can see my workshift on the marketplace

  Scenario: I put my workshift on the market after the 24 hour deadline
    When I put my workshift on the market after the deadline
    Then I should see "You can not put a workshift on the marketplace after it has started"

  Scenario: Someone buys my shift
    When I put my workshift on the market before the deadline
    And someone buys the shift
    Then I should see the workshift as sold

  Scenario: No one buys my shift
    When I put my workshift on the market before the deadline
    And no one buys my shift and the workshift has passed
    Then I should see the workshift as missed

  Scenario: I undo the selling of my shift
    Given I put my workshift on the market before the deadline
    And no one buys my shift and the workshift has not started yet
    When I am on the marketplace page
    And I follow "Undo Sell"
    Then I should not see my workshift in the Marketplace
