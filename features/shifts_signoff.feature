Feature: Sign-off a shift
  As a member of a coop,
  In order to get credit for the shifts I work,
  I would like to get signed off online by another member
  
Background:
  Given the following users exist:
  | first_name      | last_name     | email                     |   password     |    permissions   |
  | Eric            | Nelson        | ericn@berkeley.edu        |   bunnny       |      0           |
  | Alex            | Danilychev    | danilychev@berkeley.edu   |   rabbit       |      0           |
  | Giorgia         | Willits       | gwillits@berkeley.edu     |   tortoise     |      2           |
  
  And the following metashifts exist:
  | category      | description     | multiplier    |
  | Eric            | Nelson        | ericn@berkeley.edu     |  
  
  And "Eric" is logged in
  And "Giorgia" is assigned the following shifts:
  | start_time      | end_time     | metashift_id       |
  |             |        | ericn@.edu        |  
  
  
# homepage
# if you are signed in
#     pwd not required for signoff
# if you are not signed in
#     username and pwd required to sign off (but this does not sign the user in)
# if user is a manager or workshift manager
#     show special shift signoff ability
#     show recent online signoffs
#     view workshifts and descriptions link
