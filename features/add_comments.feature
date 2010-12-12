@wip
Feature: Build a way for users to comment on a status
  In order for a user to encourage another user
  A user
  Should add a comment to their status


Scenario: A user can add a comment
  Given I am logged in as "testy@test.com"
  And a win exists
  And I go to the wins page

  #When I click on a "Comment" link
