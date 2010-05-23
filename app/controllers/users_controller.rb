class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

	def create
  	@user = User.new(params[:user])
  	@user.username = params[:user][:username] #HACK: wut
  	
    if @user.save
      flash[:notice] = "Account registered!"
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
    end
    @can_update_status = false
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
