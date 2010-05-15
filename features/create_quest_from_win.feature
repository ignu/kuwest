Feature: Create quest from wins
fill this in yo

Scenario: Create a quest from wins
	When I am logged in
	And I see my wins
	When I select my wins
	And I enter a quest name
	And I submit
	Then I should see a status "Quest created"
