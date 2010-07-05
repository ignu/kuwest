class TipsController < ApplicationController

  def post_from_twitter
     @show_sidebar = !request.xhr? 
     render :layout => 'bare'
  end

  def format_your_update
     response.headers['Cache-Control'] = 'public, max-age=500'
     @show_sidebar = !request.xhr? 
     render :layout => !request.xhr? 
  end

  def post_from_twitter_ajax
     render '/tips/post_from_twitter', :layout => 'bare'
  end

end
