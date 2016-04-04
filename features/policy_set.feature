Feature: Setting Semester Policies
  As a work-shift manager,
  In order to enforce policies for the semester,
  I would like to set fining dates, the start and end of the semester, market sell-by, and fining rates.
  
  Background:
    Given I am logged in as an admin
    And I belong to "Cloyne"

  Scenario: An admin sets the policies for the semester
    When I go to the view policy page
    Then I should be on the set policies page
    When I fill in "first_day" with "January 16, 2016"
    When I fill in "last_day" with "May 17, 2016"
    When I fill in "fine_days" with "March 5, 2016"
    And  I fill in "Fine rate" with "20"
    And  I fill in "Selling Date Limit" with "48"
    And  I press "Save"
    Then I should be on the view policy page
    And I should see "Your policies have been saved"