class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :show] 
  def new
    @user = User.new
  end

  def create
  	@user = User.create(params[:user])
  	@user.update_attributes(params[:username])
  	#@user.username = params[:user][:username]
  	
    if @user.save
      flash[:notice] = "Profile created!"
      redirect_to "/users/#{@user.username}" 
    else
      render :action => :new
    end
  end
  
  def show
    throw "Need to supply a username" if params[:id].nil?
    @user = User.find_by_username params[:id]
    if @user.nil?
      @error = "Could not find User '#{params[:id]}'"
      render(:template => "shared/error404", :status => "404") 
    else
      @totals = Win.totals_for(@user)
      @can_update_status = !current_user.nil? && current_user.username == @user.username
    end
  end

  def edit
    throw "You need to be logged in to see this page" if current_user.nil?
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated."
      redirect_to "/users/#{@user.username}"
    else
      render :action => :edit
    end
  end

end
