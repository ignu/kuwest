class TipsController < ApplicationController

  def post_from_twitter
     @show_sidebar = !request.xhr? 
     render :layout => false
  end

  def format_your_update
     response.headers['Cache-Control'] = 'public, max-age=500'
     @show_sidebar = !request.xhr? 
     render :layout => !request.xhr? 
  end

end
