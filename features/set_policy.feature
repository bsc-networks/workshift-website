Feature: Setting Semester Policies
  As a work-shift manager,
  In order to enforce policies for the semester,
  I would like to set fining dates, the start and end of the semester, market sell-by, and fining rates.
  
  Background:
    Given I am logged in as an admin

  Scenario: An admin sets the policies for the semester
    When I go to the view policy page
    Then I should be on the set policies page
    When I select "January 16, 2016" as the policy "first_day"
    And I select "May 17, 2016" as the policy "last_day"
    And I select "March 5, 2016" as the policy "fine_days"
    And  I fill in "Fining Rate" with "20"
    And  I fill in "Selling Date Limit" with "48 hours"
    And  I press "Save"
    Then I should be on the view policy page
    And I should see "Your policies have been saved"