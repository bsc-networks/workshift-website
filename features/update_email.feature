Feature: see the updated email after a user updates it

	As a concerned user
	So that I can update my email address
	I want to see my updated email address

Background: previous email address

	Given I am a authenticated user

	And I am on the settings page

Scenario: update email address
Given I update my email address: shirley1@example.com
And I press "Update User"
Then I new email should be: shirley1@example.com
