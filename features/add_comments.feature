Feature: Build a way for users to comment on a status 
	In order for a user to encourage another user
	A user
	Should add a comment to their status

Scenario: A user can add a comment
	Given I am logged in as "testy@mctester.com"
		And a win exists 
		And I go to the wins page 
	
	When I click on a "Comment" link
	Then a Comment Box appears 
		And the Comment Box has focus 
	When the Comment Box blurs without entering text
	Then I do not see a Comment Box
	
	Given I type "Well Done" in a Comment Box
	When I click Submit
	Then I should see "Well Done" under the Action
	And I should not see a Comment Box
