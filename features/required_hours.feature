Feature: User Required Hours
	As a workshift manager
	So that each individual has his/her own amount of required hours
	I want to be able to set/change the amount of required hours needed from that resident

Background:
	Given I am signed in as a workshift manager
	And a resident named "Britney Spears" exists

Scenario: I want to change the user required hours to 3.0
	When I change the new required hours to 3.0
	Then I should see the Current Required Hours as 3
	And I should not see the Current Required Hours as 5