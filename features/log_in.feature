Feature: Log in to the Page

  As any user, with any set of permissions
  I want to be able to log in to the app
  So that I can view pages on the site that I have permissions for.

Background: users in database

  Given the following users exist:
  | first_name      | last_name     | email                     |   password     |    permissions   |
  | Eric            | Nelson        | ericn@berkeley.edu        |   bunnny       |      0           |
  | Alex            | Danilychev    | danilychev@berkeley.edu   |   rabbit       |      0           |
  | Yannie          | Yip           | yannie.yip@berkeley.edu   |   doggy        |      1           |
  | Giorgia         | Willits       | gwillits@berkeley.edu     |   tortoise     |      2           |

Scenario: a regular user tries to login
  When I go to the login page
  And  I fill in "Email" with "ericn@berkeley.edu"
  And  I fill in "user_password" with "bunny"
  And  I press "Log in"
  Then I should be on the home page
  
Scenario: an admin user tries to login
  When I go to the login page
  And  I fill in "Email" with "gwillits@berkeley.edu"
  And  I fill in "user_password" with "tortoise"
  And  I press "Log in"
  Then I should be on the home page
  And I should have admin rights
  
Scenario: Someone tries to login with bad credentials
  When I go to the login page
  And  I fill in "Email" with "nobody@berkeley.edu"
  And  I fill in "user_password" with "fake"
  And  I press "Log in"
  Then I should be on the login page
