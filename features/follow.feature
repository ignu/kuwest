Feature: Follow
  In order to get notified of what the people are doing
  As a user
  I want following the people
  
  Scenario: Follow another user
    Given bob signed up as "bob@example.com/111111"
    And I am signed in as "sean@example.com/111111"
    When I am on bob's profile page
    And I follow "Follow"
    Then I should be in bob's follower list
    And bob should be in my following list
  
  Scenario: No followers
    Given I am signed in as "sean@example.com/111111"
    And I have no followers
    When I am on my profile page
    Then I should not see any followers
  
  Scenario: No followings
    Given I am signed in as "sean@example.com/111111"
    And I am not following anyone
    When I am on my profile page
    Then I should not see any followings
  
  Scenario: Follow myself
    Given I am signed in as "sean@example.com/111111"
    When I am on my profile page
    Then I should not see "Follow"
  
  Scenario: Unfollow
    Given bob signed up as "bob@example.com/111111"
    And I am signed in as "sean@example.com/111111"
    And I have followed bob
    When I am on bob's profile page
    Then I should be in bob's follower list
    When I follow "Unfollow"
    Then I should not be in bob's follower list
    
  
  
  
  
  
  
  
  
  
  

  
