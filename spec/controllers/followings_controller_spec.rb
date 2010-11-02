require 'spec_helper'

describe FollowingsController do
  def signin_as(email, username, password)
    user = User.create(:email => email, :password => password, :password_confirmation => password, :username => username)
    sign_in user
    user
  end

  def signin_mock
    user = mock_model(User) 
    sign_in user
    user
  end

  describe 'POST create action' do

    let (:user) {User.create(:username => 'bob', :email => 'bob@example.com', :password => '111111')}

    it "requires login" do
      controller.stubs(:current_user).returns(user)
      post :create, :following_id => 1
      response.should redirect_to new_user_session_path
    end

    it "creates following and redirect to user profile page" do
      follower = signin_as('sean@example.com', 'sean', '111111')
      following = User.create(:username => 'bob', :email => 'bob@example.com', :password => '111111')
      lambda { post(:create, :following_id => following.id) }.should change {Following.count}
      response.should redirect_to "/users/#{following.username}"
    end
  end


  describe 'destroy action' do
    it "destroys following and redirect to user profile page" do
      follower = signin_as('sean@example.com', 'sean', '111111')
      following = User.create(:username => 'bob', :email => 'bob@example.com', :password => '111111')
      f = Following.create(:follower => follower, :following => following)
      lambda {get :destroy, :id => f.id}.should change {Following.count}.by -1
      response.should redirect_to "/users/sean"
    end
  end

end
