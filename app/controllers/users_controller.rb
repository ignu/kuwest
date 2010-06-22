class UsersController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:new, :show, :create]
  def add_stored_message 
      return unless cookies[:status]
      win_view_model = WinViewModel.new(
        :username=>@user.username,
        :body=>cookies[:status])
      win_view_model.to_win.save
  end 

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    @user.update_attributes(params[:username])
  	
    if @user.save
      sign_in :user, @user
      add_stored_message
      flash[:notice] = "Your account has been created!"
      redirect_to "/users/#{@user.username}" 
    else
      render :action => :new
    end
  end
  
  def show
    throw "Need to supply a username" if params[:id].nil?
    @user = User.find_by_username(params[:id])
    @title = "#{@user.username}'s profile [kuwest.com]"
    @page = params[:page]
    @page ||= 1
    if @user.nil?
      @error = "Could not find User '#{params[:id]}'"
      render(:template => "shared/error404", :status => "404") 
      return
    else
      @wins = Win.paginate_by_user_id @user.id, {:page=> @page, :per_page=>25}
      @totals = Win.totals_for(@user)
      @data = WinGraphData.new @user
      @can_update_status = !current_user.nil? && current_user.username == @user.username
    end
    
    respond_to do |format|
      format.html
      format.json { render :json => WinGraphData.new(@user) }
    end
  end
  
  #TODO: delete this once we stop messing around with the graph
  def graph
    throw "Need to supply a username" if params[:id].nil?
    @user = User.find_by_username params[:id]
    if @user.nil?
      @error = "Could not find User '#{params[:id]}'"
      render(:template => "shared/error404", :status => "404") 
      return
    else
      @totals = Win.totals_for(@user)
      @data = WinGraphData.new @user
      @can_update_status = !current_user.nil? && current_user.username == @user.username
    end
    
    respond_to do |format|
      format.html
      format.json { render :json => WinGraphData.new(@user) }
    end
  end
  
  def edit
    throw "You need to be logged in to see this page" if current_user.nil?
    @user = current_user
  end
  
  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      @user.save!
      flash[:notice] = "Profile updated."
      redirect_to "/users/#{@user.username}"
    else
      render :action => :edit
    end
  end

end
