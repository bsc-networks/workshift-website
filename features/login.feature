Feature: sign up and login
    As a resident
    So that I can enter and check my shifts for the week
    I want to be able to use my email address and password to login to the website

    Scenario: See login/signup page if not logged in
        Given I am not signed in
        When I go to the home page
        Then I should see "Sign in"

    Scenario: Sign up as a new user
        Given I am not signed in
        And I am on the register page
        When I fill in the following:
            | Name                  | Jane Doe         |
            | Email                 | user@example.com |
            | Password              | secret           |
            | Password confirmation | secret           |
        And I press "Create User"
        Then I should see "Welcome! You have signed up successfully"

    Scenario: Sign in as existing user
        Given I have an account with email "test@example.com" and password "secret"
        And I am not signed in
        Then I can sign in using email "test@example.com" and password "secret"
