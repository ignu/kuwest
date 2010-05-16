class WinsController < ApplicationController

  def index
    @wins = Win.find(:all, :order=>"id desc", :limit=>10)
  end

  def new
    @win = Win.new
  end
  
  def create
    @win_view_model = WinViewModel.new(
      :user=>current_user,
      :body=>params[:body])
    @win_view_model.to_win.save!
    render :json => @win_view_model.to_json
  end
  
end
