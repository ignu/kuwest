require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User, "Validations" do
  subject{User.new}
	it { should have_many :wins}
	it { should have_many :comments}
	it { should validate_uniqueness_of :username}
end

describe User, "#xp" do
  before(:each) do
    @user = Factory.create(:user)
    @win = Win.new({:noun=>"autobots", :verb=>"killed", :amount=>3})
    @win.user = @user
    @win.save!
  end
  
  it "adds 3 xp for each status update" do
    @user.xp.should == 13
  end

  it "adds 5xp for first comment" do 
    @user.xp.should  == 13
    @user.wins.length.should > 0
    comment = Comment.new
    comment.user, comment.body =  @user, "test"
    @user.wins.first.comments << comment
    comment.save!
    @user.xp.should == 18
  end

  it "calculate levels based on xp_limits array" do 
    u = User.new
    User.xp_limits.each_index do |i| 
      u.xp = User.xp_limits[i]
      u.level.should == i-1
    end
  end

  it "calculates the percent to next level" do 
    u = User.new
    u.xp = User.xp_limits[3] + 10
    u.level.should == 3
    u.level_progress.should == 10/(User.xp_limits[4] - User.xp_limits[3]).to_f
  end
end

