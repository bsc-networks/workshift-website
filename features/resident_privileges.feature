Feature: Ordinary co-op residents shouldn't be able to change workshifts
  As the workshift manager
  So that residents interfere with my duties
  I want residents to not be able to tamper with workshifts

  Background: I am an ordinary resident with no admin privileges
    Given I am signed in as an authenticated user

  Scenario: Cannot edit workshifts
    Given I am on the workshifts listings page
    Then I should not see any "Edit" links

  Scenario: Cannot delete workshifts
    Given I am on the workshifts listings page
    Then I should not see any "Destroy" links

  Scenario: Cannot create new workshifts
    Given I am on the workshifts listings page
    Then I should not see any "New Workshift" links
