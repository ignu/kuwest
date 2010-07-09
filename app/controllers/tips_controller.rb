class TipsController < ApplicationController

  def post_from_twitter
     @show_sidebar = !request.xhr? 
     render :layout => !request.xhr? 
  end

  def format_your_update
     @show_sidebar = !request.xhr? 
     render :layout => !request.xhr? 
  end

end
