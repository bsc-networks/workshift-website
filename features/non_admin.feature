Feature: Restrict Non-admin User From Editing
  As a non-admin user,
  In order to not be able to tamper with workshift assignments and policies,
  I want to not be able to edit.
  
  Background:
    Given I am logged in as a non-admin
    
  Scenario: Non-admin tries to edit
    When I go to the view policy page
    Then I should not see "Edit"