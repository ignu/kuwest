class AfterTwitterLoginController < ApplicationController
  def login_to_devise
    
    # Then I should have an account created with my Twitter username
    #    And my avatar should be my twitter avatar
    #    And my Name should be filled out from my twitter profile
    #    And the twitter field in my profile should match my twitter username
    if twitter_user
      unless user = User.find_by_twitter_name(twitter_user.screen_name)
        user = User.new(:twitter_name => twitter_user.screen_name)
        user.save(false)
      end
      sign_in :user, user
    else
      
    end
    redirect_to root_path
  end
  
end