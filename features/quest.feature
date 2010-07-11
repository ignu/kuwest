Feature: Quests

As a user
In order to work towards a goal I care aboue
I want to be able to create a Quest

Scenario: Create Quests
Given I am on the new quest page
And I am signed in as "ignu@example.com/111111"
And I fill in "name" with "1000 Mile runner quest"
And I fill in "description" with "1000 Mile runner quest"
And I fill in "Run 100 Miles" in "Objectives"
When I press "Submit"
Then I should see "Quest Created!"
And that Quest should be added to my quests
