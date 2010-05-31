class WinsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @wins = Win.find(:all, :order=>"id desc", :limit=>10)
  end

  def new
    @win = Win.new
  end

  def destroy
    win = Win.find(params[:id])
    throw "Can Not Delete Another's Status" unless win.user.id == current_user.id
    win.destroy
    render :json => {:message => "Status deleted." }
  end 

  def update
    win = Win.find(params[:id])
    win.update_attributes(params[:win])
  end
  
  def picture
    @win = Win.find(params[:id])
    @win.photo = params[:photo]
    @win.save!
    render "shared/_status_photo", :layout=>false
  end

  def create
    win_view_model = WinViewModel.new(
      :username=>current_user.username,
      :body=>params[:body])
    @win = win_view_model.to_win
    @win.save!
    render "shared/_status_tr", :layout=>false
  end

  def comment
    throw "need to be signed in" if current_user.nil?
		comment = Comment.new(
      :user => current_user,
			:body => params[:body],
			:win => Win.find_by_id(params[:id]))				
		comment.save
		@comment = comment
		render "shared/_comment", :layout=>false
  end

end
