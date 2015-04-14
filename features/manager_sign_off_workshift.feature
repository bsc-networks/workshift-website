Feature: Workshift manager can sign off completed workshifts
	As the workshift manager
	In the case that a verifier forgets/refuses to sign off a workshift
	even though the workshift has been completed
	The manager can manually sign off the workshift

Background:
	Given I am signed in as a workshift manager
	And a resident named "Bobby Gee" exists
	And the shift "Wash the dishes" exists
	And Bobby Gee is assigned to the shift "Wash the dishes"

Scenario: I mark the shift as complete
	When I mark the shift "Wash the dishes" as completed
	Then the status of the workshift should be "completed"