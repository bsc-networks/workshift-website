Feature: display list of all residents

  Background: residents have been added to database
    Given 20 residents exist

  Scenario: all residents' names are displayed on roster page when signed in
    When I am signed in as a resident
    And I am on the roster page
    Then every resident's name should be visible

  Scenario: must be signed in to view the roster
    When I am not signed in
    And I go to the roster page
    Then I should see "You need to sign in"
