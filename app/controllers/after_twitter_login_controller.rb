class AfterTwitterLoginController < ApplicationController
  def twitter_hack
    redirect_to "https://api.twitter.com/oauth/authenticate?oauth_token=#{params[:oauth_token]}"
  end
  
  def new
    redirect_to_twitter(request)
  end
  
  def login_to_devise
    # if request[:oauth_verifier]
    #     twitter_user = Hashie::Mash[handle_twitter_authorization(request)] 
    #     # request.session[:twitter_user] = Hashie::Mash[session[:twitter_user]]
    #   elsif request[:denied]
    #     # user refused to log in with Twitter, so give up
    #     handle_denied_access(request)
    #     redirect_to root_path and return
    #   end
    
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
   end
  end
  
  
  protected
  
  def redirect_to_twitter(request)
    # create a request token and store its parameter in session
    oauth.set_callback_url(after_twitter_login_url)
    
    request.session[:request_token] = [oauth.request_token.token, oauth.request_token.secret]
    redirect_url = oauth.request_token.authorize_url
    redirect_url = "http://" + redirect_url unless redirect_url.start_with?("http://")
    redirect_to redirect_url
    
  end
  
  def handle_twitter_authorization(request)
    authorize_from_request(request)
    
    # get and store authenticated user's info from Twitter
    twitter.verify_credentials.to_hash
    
    # # pass the request down to the main app
    #     response = begin
    #       yield
    #     rescue
    #       raise unless $!.class.name == 'ActionController::RoutingError'
    #       [404]
    #     end
    #     
    #     # check if the app implemented anything at :login_path
    #     if response[0].to_i == 404
    #       # if not, redirect to :return_to path
    #       redirect_to_return_path(request)
    #     else
    #       # use the response from the app without modification
    #       response
    #     end
  end
  
  def handle_denied_access(request)
    request.session[:request_token] = nil # work around a Rails 2.3.5 bug
    request.session.delete(:request_token)
    #redirect_to_return_path(request)
    flash[:error] = "You should not denied access if you want to login through twitter!"
  end
  

  # replace the request token in session with access token
  def authorize_from_request(request)
    rtoken, rsecret = request.session[:request_token]
    oauth.authorize_from_request(rtoken, rsecret, request[:oauth_verifier])
    
    request.session.delete(:request_token)
    request.session[:access_token] = [oauth.access_token.token, oauth.access_token.secret]
  end
  
  # def redirect_to_return_path(request)
  #    redirect request.url_for(options[:return_to])
  #  end
  
  # def redirect(url)
  #   ["302", {'Location' => url, 'Content-type' => 'text/plain'}, []]
  # end
  
  def oauth
    consumer_key = 'FwXG209iTDLYZ0ZTouw'
    secret = 'NuOUDsaIF4lyUYaY62YIDDX7qb6JwmMECShrmIMVRM'
    @oauth ||= Twitter::OAuth.new consumer_key, secret, :sign_in => true
  end
  
  def twitter
    Twitter::Base.new oauth
  end
end
