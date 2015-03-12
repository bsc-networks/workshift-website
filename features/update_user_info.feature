Feature: see the updated info after a user changes it
    As a concerned user
    So that I can update my profile information
    I want to see my changes to my profile info

    Background: original user profile info
        Given I have an account with email "test@example.com" and password "secret"
        And I am signed in using email "test@example.com" and password "secret"
        And I am on the settings page

    Scenario: update email address
        When I fill in "Email" with "new_email@example.com"
        And I save my setting preferences
        Then my email should be "new_email@example.com"
        When I log out
        Then I can sign in using email "new_email@example.com" and password "secret"

    Scenario: update password
        When I fill in the following:
            | New Password         | newsecret |
            | Confirm New Password | newsecret |
        And I save my setting preferences
        And I log out
        Then I can sign in using email "test@example.com" and password "newsecret"

    Scenario: update phone number
        When I fill in "Phone Number" with "(999) 999-9999"
        And I save my setting preferences
        Then my phone_number should be "(999) 999-9999"

    Scenario: update room number
        When I fill in "Room Number" with "123456"
        And I save my setting preferences
        Then my room_number should be "123456"
