Feature: Register
  I should be able to register an account
  As a user
  In order to use the site

Scenario: Normal Registration
  Given I am on the new user page
  When I fill in "Username" with "ratbat"
  And I fill in "Email" with "ratbat@decepticons.com"
  And I fill in "Password" with "ihateautobots"
  And I fill in "Password confirmation" with "ihateautobots"
  And I press "Sign up"
  Then I should see "Your account has been created!"