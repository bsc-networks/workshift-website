Feature: Viewing User Profile as and Admin
  As a workshift manager,
  In order to manage coop workshifts and stay on track of my own hours,
  I would like to view my information and be able to edit users and workshifts on one page.
  
  Background:
    Given I am the following user:
    | first_name | last_name | email           | password | permissions | hour_balance | fine_balance |
    | Giorgia    | Willits   | gw@berkeley.edu | hare     | 2           | 10           | 0            |
    And I am logged in

  Scenario: A manager views their profile
    Given I am on the home page
    When I follow "Profile"
    Then I should be on my profile page
    Then I should see the following: "Hour Balance", "Fine Balance", "Permanent Shift Assignment", "Signoff History", "10", "0"
    And I should see "Edit Profile"
    And I should see the following: "Create Users", "Create Workshifts", "Assign Workshifts", "View Weekly History"
    
  Scenario: A manager creates users from their profile page
    Given I am on my profile page
    When I follow "Create Users"
    Then I should be on the create members page
    
  Scenario: A manager creates workshifts from their profile page
    Given I am on my profile page
    When I follow "Create Workshifts"
    Then I should be on the create workshifts page
    
  Scenario: A manager assigns workshifts from their profile page
    Given I am on my profile page
    When I follow "Assign Workshifts"
    Then I should be on the assign workshifts page
    
  Scenario: A manager views weekly history from their profile page
    Given I am on my profile page
    When I follow "View Weekly History"
    Then I should be on the view weekly history page
    