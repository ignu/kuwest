class WinsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index, :create]

  def index
    @wins = Win.find(:all, :order=>"id desc", :limit=>12, :include=>[:user,:comments])
  end

  def edit 
    @win = Win.find(params[:id])
    redirect_to "/" if @win.user.id != current_user.id    
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
    redirect_to({:action=>"index", :controller=>"wins"})
  end
  
  def picture
    @win = Win.find(params[:id])
    @win.photo = params[:photo]
    @win.save!
    render "shared/_status_photo", :layout=>false
  end

  def create
    if current_user.nil?
      cookies[:status] = params[:body]
      respond_to do |r|
        r.json {render :text=> "Must log in", :status => 302}
        r.html do
          flash[:error] = "You have to be registered to do that"
          redirect_to({:action=>"new", :controller=>"users"})
        end
      end

      return
    end    

    win_view_model = WinViewModel.new(
      :username=>current_user.username,
      :body=>params[:body])
    @win = win_view_model.to_win
    @win.save!
    return redirect_to "/users/#{current_user.username}" unless request.xhr? 

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
