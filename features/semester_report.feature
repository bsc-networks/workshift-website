Feature: entire semester's csv report
  As the workshift manager
  So that I can view the hours balance for everyone over the entire semester
  I want to be able to download a report of the whole semester as a CSV file

  Background:
    Given I am signed in as a workshift manager
    And I am on the reports page

  Scenario: can download the semester report
    When I follow "Download Semester Report"
    Then I should get a download with the filename "semester_report.csv"

  Scenario: report includes every users' overall hours balance
    Given a resident named "Bobby Gee" exists
    And "Bobby Gee" is up 4 hours
    And a resident named "Sally Jones" exists
    And "Sally Jones" is down 7 hours
    When I follow "View Semester Report"
    Then I should see "Bobby Gee,4"
    And I should see "Sally Jones,-7"
