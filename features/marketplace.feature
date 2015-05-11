Feature: Workshift Marketplace
  As a resident
  So that I can give away workshift assignments that I cannot complete
  And so that I can earn extra points by taking up shifts that others can't complete
  I want to be able to sell and buy shifts on the workshift marketplace

  Background: Selling a shift before 24 hour 'deadline'
    Given I am assigned to the shift "Dishes" with start time "11:00am" and end time "12:00pm" with day "2"

  Scenario: I put my workshift "Dishes" on the market before the 24 hour deadline
    Given I put my workshift "Dishes" on the market before the deadline
    Then I can see my workshift on the marketplace

  Scenario: I put my workshift "Dishes" on the market after the 24 hour deadline
    Given I put my workshift "Dishes" on the market after the deadline
    Then I should see an error

  @rufus
  Scenario: Someone buys my shift
    Given someone buys shift "Dishes" with start time "11:00am" and end time "12:00pm" with day "2"
    Then I should see the workshift as sold

  @rufus
  Scenario: No one buys my shift 
    Given I put my workshift "Dishes" on the market before the deadline
    And no one buys my shift "Dishes" and the workshift has passed
    Then I should see the workshift as missed

  @rufus
  Scenario: I undo the selling of my shift
    Given no one buys my shift and the workshift has not started yet
    And I click "Undo"
    Then I should not see my workshift in the Marketplace
