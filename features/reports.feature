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

  Scenario: generated report has current day's date in title
    When the date is currently April 6th, 2015 1:30pm
    And a new weekly report is generated
    Then the title of the report contains today's date

  Scenario: workshift manager can download the reports
    Given a new weekly report is generated
    When I am on the reports page
    Then I can download the weekly report

  Scenario: workshift manager can view the text of the report
    Given a new weekly report is generated
    When I am on the view report page
    Then I should see the text of that report

  Scenario: a regular resident cannot view the reports
    When I log out
    And I sign in as a resident
    And I go to the reports page
    Then I should be on the home page
