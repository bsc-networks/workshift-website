Feature: Editing the Policy page

    As a work-shift manager,
    I would like to set fining dates, the start and end of the semester, market sell-by, and fining rates on one page.
    So that my members abide by my policies for the semester.

Scenario: an admin tries to set the policies
  When I go to the admin policies page
  And I follow "Edit"
  Then I should be on the edit policies page
  When  I fill in "Start Date" with "01-26-2016"
  And  I fill in "End Date" with "05-05-2016"
  And  I fill in "Fining Date" with "03-05-2016"
  And  I fill in "Market Sell-By Limit" with "48 hours"
  And  I press "Save"
  Then I should be on the admin policies page
  And I should see "Your changes have been saved"
 
  