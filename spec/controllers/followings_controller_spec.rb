require 'spec_helper'

describe FollowingsController do
  
  describe 'POST create action' do
    it "should require login" do
      post :create, :following_id => 1
      response.should redirect_to new_user_session_path(:unauthenticated => true)
    end
    
    it "should create following and redirect to user profile page" do
      follower = signin_as('sean@example.com', 'sean', '111111')
      following = User.create(:username => 'bob', :email => 'bob@example.com', :password => '111111')
      lambda {post :create, :following_id => following.id}.should change {Following.count}
      response.should redirect_to user_show_path(:id => following.username)
    end
  end
  

  describe 'destroy action' do
    it "should destroy following and redirect to user profile page" do
      follower = signin_as('sean@example.com', 'sean', '111111')
      following = User.create(:username => 'bob', :email => 'bob@example.com', :password => '111111')
      f = Following.create(:follower => follower, :following => following)
      lambda {get :destroy, :id => f.id}.should change {Following.count}.by -1
      response.should redirect_to user_show_path(:id => following.username) 
    end
  end
end
