require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "can be persisted with valid attributes" do
    valid_hash = {
      :email                  => "test@test.com",
      :password               => "megatron",
      :password_confirmation  => "megatron"}

    user = User.new valid_hash
    user.username = "ratbat"
    user.save!.should == true
    user.id.should be > 0
    user.username.should == "ratbat"
    user.email.should == "test@test.com"
  end

  it {should have_many :wins}
  it {should have_many :comments}
  it do
    User.make
    should validate_uniqueness_of :username
  end
end

describe User, "#xp" do
  let (:user) { User.make }
  let (:win)  { Win.make(:user => user) }

  before do
    user.save
  end

  it "adds 3 xp for each status update" do
    win.save
    user.xp.should == 13
  end

  it "adds 5xp for first comment" do
    win.save
    user.xp.should  == 13
    user.wins.length.should > 0
    comment = Comment.new
    comment.user, comment.body =  user, "test"
    user.wins.first.comments << comment
    comment.save!
    user.xp.should == 18
  end

  it "calculate levels based on xp_limits array" do
    User.xp_limits.each_index do |i|
      user.xp = User.xp_limits[i]
      user.level.should == i-1
    end
  end

  it "calculates the percent to next level" do
    user.xp = User.xp_limits[3] + 10
    user.level.should == 3
    user.level_progress.should == 10/(User.xp_limits[4] - User.xp_limits[3]).to_f
  end
end

