Feature: Log in to the Page

  As any user, with any set of permissions
  I want to be able to log in to the app
  So that I can view pages on the site that I have permissions for.

Background: users in database

  Given the following users exist:
  | first_name      | last_name     | email                     | permissions   |
  | Eric            | Nelson        | ericn@berkeley.edu        |   0           |
  | Alex            | Danilychev    | danilychev@berkeley.edu   |   0           |
  | Yannie          | Yip           | yannie.yip@berkeley.edu   |   1           |
  | Giorgia         | Willits       | gwillits@berkeley.edu     |   2           |

Scenario: a regular user tries to login
  When I go to the login page
  And  I fill in "email" with "ericn@berkeley.edu"
  And  I press "log in"
  Then I should be on the user page

