require 'spec_helper'

describe Following do
  it "should validates uniqueness of follower and following" do
    follower =  User.create(:username => 'sean', :email => 'sean@example.com', :password => '111111')
    following = User.create(:username => 'bob', :email => 'bob@example.com', :password => '111111')
    Following.create(:follower => follower, :following => following)
    lambda {Following.create(:follower => follower, :following => following)}.should_not change {Following.count}
  end
end
