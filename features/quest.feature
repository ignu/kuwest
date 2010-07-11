Feature: Quests

As a user
In order to work towards a goal I care aboue
I want to be able to create a Quest

@javascript
  Scenario: Create Quests

    Given I am signed in as "ignu@example.com/111111"
    And I am on the new quest page
    Then I should see "Add new Quest"
    And I fill in "quest[name]" with "1000 Mile runner quest"
    And I fill in "description" with "1000 Mile runner quest"
    And I fill in "objective" with "Run 100 Miles"
    When I press "Create Quest" 
    Then I should see "Quest Created!"
    And that Quest should be added to my quests
