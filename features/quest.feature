Feature: Quests

As a user
In order to work towards a goal I care aboue
I want to be able to create a Quest

Scenario: Create Quests
  Given I am signed in as "ignu@example.com/111111"
  And I am on the new quest definition page
  Then I should see "Add a new Quest"
  When I fill in "quest_definition[name]" with "1000 Mile runner quest"
  And I fill in "quest_definition[objective]" with "Run 100 Miles"
  And I press "Start"
  Then I should see "Quest Created!"
  And I should have the quest definition "1000 Mile runner quest"
  And my quest definition should have the objective "Run 100 Miles"
  And I should have the quest "1000 Mile runner quest"
  And my objectives should contain "Run 10 Miles"

  When I fill in "body" with "Ran 8 Miles"
  And I press "submit_activity"
  Then I should see "2 miles remaining"

  When I fill in "body" with "Ran 8 Miles"
  And I press "submit_activity"
  Then I should see "34 miles remaining"
