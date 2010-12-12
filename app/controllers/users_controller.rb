class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :user_not_found
  before_filter :authenticate_user!, :only => [:edit, :update]

  def new
    @user = User.new({:allow_email => true})
  end

  def top
    @users = User.find(:all, :conditions=>["xp > 0"], :order=>"xp DESC", :limit=>10)
  end

  def create
    @user = User.new(params[:user])
    @user.update_attributes(params[:username])

    if @user.save
      sign_in :user, @user
      add_stored_message
      flash[:notice] = "Your account has been created!"
      redirect_to user_path(@user)
    else
      render :action => :new
    end
  end

  def show
    #TODO: consider presenter
    @user = User.find(params[:id])
    @page = params[:page] || 1
    @wins = Win.paginate_by_user_id @user.id, {:page=> @page, :per_page=>25, :order=>"id DESC"}

    @title = "#{@user.username}'s profile [kuwest.com]"
    @totals = Win.totals_for(@user)
    @data = WinGraphData.new @user
    @can_update_status = !current_user.nil? && current_user.username == @user.username

    # TODO: this is not the same resource.
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
      redirect_to user_path @user
    else
      render :action => :edit
    end
  end

  private

  def add_stored_message
      return unless cookies[:status]
      win_view_model = WinViewModel.new(
        :username=>@user.username,
        :body=>cookies[:status])
      win_view_model.to_win.save
  end

  def user_not_found
    @error = "Could not find User '#{params[:id]}'"
    render(:template => "shared/error404", :status => "404")
  end
end
