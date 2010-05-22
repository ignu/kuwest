class WinsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show, :index] 

  def index
    @wins = Win.find(:all, :order=>"id desc", :limit=>10)
    #TERRIBLE TEMP HACK  #HACK
    @wins.each do |w|
      if w.user.nil?
        w.user = User.new
        w.user.username = "ignu"
      end
    end

  end

  def new
    @win = Win.new
  end
  
  def create
    win_view_model = WinViewModel.new(
      :username=>current_user.username,
      :body=>params[:body])
    win_view_model.to_win.save!
    render :json => win_view_model.to_json
  end
  
end
