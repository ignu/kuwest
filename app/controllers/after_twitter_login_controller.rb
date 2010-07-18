class AfterTwitterLoginController < ApplicationController
  def twitter_hack
    throw "WLKASJDLKAJSLDKJS"
    redirect_to "https://api.twitter.com/oauth/authenticate?oauth_token=#{params[:oauth_token]}"
  end

  def login_to_devise
    if twitter_user
      unless user = User.find_by_twitter_name(twitter_user.screen_name)
        first_name, last_name = twitter_user.name.split unless twitter_user.name.blank?
        redirect_to new_user_registration_path(
          "hide_password"  => true,
          "user[username]" => twitter_user.screen_name, 
          "user[twitter_name]" => twitter_user.screen_name,
          "user[first_name]" => first_name,
          "user[photo]" => twitter_user.profile_image_url.gsub(/_normal/,''),
          "user[last_name]" => last_name)
      else
        sign_in :user, user
        redirect_to root_path
      end
    else
      flash[:error] = "Something is wrong!"
      redirect_to root_path
    end
  end
  
end
