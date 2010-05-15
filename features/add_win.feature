Feature: Adding a win into the website
	In order to start tracking my stuff
	As a user
	I want to be able to enter a win

Scenario: Add a win
	Given I am logged in
	And I am on the dashboard
	When I enter a win
	Then I should see the status "Win!" 
