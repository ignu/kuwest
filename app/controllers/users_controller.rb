class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :user_not_found
  
  before_filter :authenticate_user!, :except => [:new, :show, :create, :top]
  def add_stored_message 
      return unless cookies[:status]
      win_view_model = WinViewModel.new(
        :username=>@user.username,
        :body=>cookies[:status])
      win_view_model.to_win.save
  end 

  def new
    @user = User.new
    @user.allow_email = true
  end

  def top
    @users = User.find(:all, :conditions=>["xp > 0"], :order=>"xp DESC", :limit=>10)
  end

  def create
    @user = User.create(params[:user])
    @user.update_attributes(params[:username])
	
    if @user.save
      sign_in :user, @user
      add_stored_message
      flash[:notice] = "Your account has been created!"
      redirect_to user_show_path(@user) 
    else
      render :action => :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    @page = params[:page]
    @page ||= 1
    
    @title = "#{@user.username}'s profile [kuwest.com]"      
    @wins = Win.paginate_by_user_id @user.id, {:page=> @page, :per_page=>25, :order=>"id DESC"}
    @totals = Win.totals_for(@user)
    @data = WinGraphData.new @user
    @can_update_status = !current_user.nil? && current_user.username == @user.username
   
    respond_to do |format|
      format.html
      format.json { render :json => WinGraphData.new(@user) }
    end
  end
  
  #TODO: delete this once we stop messing around with the graph
  def graph
    @user = User.find params[:id]
    
    @totals = Win.totals_for(@user)
    @data = WinGraphData.new @user
    @can_update_status = !current_user.nil? && current_user.username == @user.username
  
    respond_to do |format|
      format.html
      format.json { render :json => WinGraphData.new(@user) }
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      @user.save!
      flash[:notice] = "Profile updated."
      redirect_to user_show_path(@user) 
    else
      render :action => :edit
    end
  end
  
  private
  def user_not_found
    @error = "Could not find User '#{params[:id]}'"
    render(:template => "shared/error404", :status => "404")
  end
end
