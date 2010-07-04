class FollowingsController < ApplicationController

  before_filter :authenticate_user!

  def create
    following = User.find(params[:following_id])
    Following.create(:follower => current_user, :following => following)
    redirect_to user_show_path(:id => following.username)
  end
end
