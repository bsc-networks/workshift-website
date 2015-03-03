Feature: see the updated info after a user changes it
	As a concerned user
	So that I can update my profile information
	I want to see my changes to my profile info

Background: original user profile info
  Given I have an account with email "test@example.com" and password "secret" and name "Test User"
  And I am signed in using email "test@example.com" and password "secret"
  And I am on the settings page

Scenario: update email address
  When I fill in "Email" with "newemail@example.com"
  And I fill in "Current password" with "secret"
  Then I press "Update User"
  And I am on the home page
  Then I should see "newemail@example.com"

Scenario: update password
  When I fill in the following:
    | New Password          | newsecret           |
    | Confirm New Password  | newsecret           |	
    | Current password  		| secret     				  |
  And I press "Update User"
  And I log out
  When I am on the login page
  And I fill in the following:
    | Email     | test@example.com |
    | Password  | newsecret        |
  And I press "Sign In"
  Then I should be signed in
