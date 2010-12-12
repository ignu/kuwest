Feature: Register
  I should be able to register an account
  As a user
  In order to use the site

Scenario: Normal wRegistration
  Given I am on the new user page
  Then show me the page
  When I fill in "Username" with "ratbat"
  And I fill in "Email" with "ratbat@decepticons.com"
  And I fill in "Password" with "ihateautobots"
  And I fill in "Password confirmation" with "ihateautobots"
  And I press "Sign up"
  Then I should see "Your account has been created!"

Scenario: Remember status
  Given I am on the home page
  When I fill in "win" with "killed one autobot"
  And I press "submit_activity"
  #Don't know why this doesn't read my flash message
  #Then I should see "You have to be registered to do that"
  Then I should see "Register now"
  When I fill in "Username" with "ratbat"
  And I fill in "Email" with "ratbat@decepticons.com"
  And I fill in "Password" with "ihateautobots"
  And I fill in "Password confirmation" with "ihateautobots"
  And I press "Sign up"
  Then I should see "Your account has been created!"
  And I should see "killed 1 au"
