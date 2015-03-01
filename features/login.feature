Feature: sign up and login
  
  As a resident
  So that I can enter and check my shifts for the week
  I want to be able to sign up and login to the website with my email and password

Scenario: See login/signup page if not logged in
  Given I am not signed in
  And I am on the home page
  Then I should see "Sign in"

Scenario: Sign up as a new user
  Given I am on the login page
  And I follow "Sign up"
  Then I should be on the register page
  When I fill in the following:
    | Name                  | Jane Doe         |
    | Email                 | user@example.com |
    | Password              | testtest         |
    | Password confirmation | testtest         |
  And I press "Create User"
  Then I should see "Welcome! You have signed up successfully"

Scenario: Log in as existing user
  Given I am a new, authenticated user
  And I am not signed in
  And I am on the login page
  When I fill in the following:
    | Name     | Jane Doe |
    | Password | testtest |
