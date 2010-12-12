require 'spec_helper'

describe Following do

  let (:follower)  { User.make }
  let (:following) { User.make :username => "bob", :email => "bob@wut.com" }

  it "should validates uniqueness of follower and following" do
    Following.create(:follower => follower, :following => following)
    lambda {Following.create(:follower => follower, :following => following)}.should_not change {Following.count}
  end

  it "should not follow myself" do
    lambda {Following.create(:follower => follower, :following => follower)}.should_not change {Following.count}
  end
end
