Feature: sign up and login
  
  As a resident
  So that I can enter and check my shifts for the week
  I want to be able to sign up and login to the website with my email and password

Scenario: See login/signup page if not logged in
  Given I am not logged in
  And I am on the home page
  Then I should should see "Sign in"

Scenario: Sign up and log in
  Given I am on the login page
  And I click on "Sign up"
  Then I should be on the register page
  When I fill in:
    | field                 | value            |
    | Name                  | Jane Doe         |
    | Email                 | user@example.com |
    | Password              | testtest         |
    | Password Confirmation | testtest         |
  And I click
