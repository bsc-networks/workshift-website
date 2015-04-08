@time-travel
Feature: workshift managers can see generated reports on residents weekly
  hours balances

  As a workshift manager
  So that I can see which of my residents are not completeing their workshifts
  I want to be able to view reports that are auto-generated that tell me what
  each residents balance of hours for that week is.

  Background:
    Given I am signed in as a workshift manager
    And a resident named "Bobby Gee" exists
    And no weekly reports exist
    And I am on the reports page
