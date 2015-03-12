Feature: customize whether my contact information is displayed on my profile
  As a resident
  So that I can keep my contact information private
  I want to be able to customize what gets shown on my profile from the
  settings page.

  Background: user profile info
    Given I have an account with email "test@example.com" and password "secret"
    And I am signed in using email "test@example.com" and password "secret"
    And my phone_number is "(999) 999-9999"
    And my room_number is "14a"
    And I am on the settings page

  Scenario: allow email to be displayed
    When I check "Display email"
    And I save my setting preferences
    When I go to my profile page
    Then I should see "test@example.com"

  Scenario: allow phone number to be displayed
    When I check "Display phone number"
    And I save my setting preferences
    When I go to my profile page
    Then I should see "(999) 999-9999"

  Scenario: not allow email to be displayed
    When I uncheck "Display email"
    And I save my setting preferences
    When I go to my profile page
    Then I should not see "test@example.com"

  Scenario: not allow phone number to be displayed
    When I uncheck "Display phone number"
    And I save my setting preferences
    When I go to my profile page
    Then I should not see "(999) 999-9999"
