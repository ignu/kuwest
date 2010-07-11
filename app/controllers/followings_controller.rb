class FollowingsController < ApplicationController

  before_filter :authenticate_user!

  def create
    following = User.find(params[:following_id])
    Following.create(:follower => current_user, :following => following)
    redirect_to user_show_path(:id => following.id)
  end
  
  def destroy
    follow = current_user.follows.find(params[:id])
    follow.destroy
    redirect_to user_show_path(:id => follow.following.id)
  end
end
