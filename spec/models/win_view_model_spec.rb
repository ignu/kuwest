require 'spec_helper'

describe WinViewModel do
  #TODO: use machinist
  before(:each) do
    @user = User.find_or_create_by_username("megatron")
    @user.email = "megatron@decepticons.com"
    @user.password = "ihateautobots"
    @user.password_confirmation = "ihateautobots"
    @user.save!
  end


  it "can be initialized from hash" do
    win_view_model = WinViewModel.new({:body=>"ran 3 miles", :username=>"ignu"})
    win_view_model.body.should == "ran 3 miles"
    win_view_model.username.should == "ignu"
  end

  it "can persist a valid win" do
    win_view_model = WinViewModel.new(:body=>"ran 3 miles", :username=>"megatron")
    win = win_view_model.to_win
    win.verb.should == "ran"
    win.amount.should == 3
    win.noun.should == "miles"
    win.save!.should ==  true
    win.id.should be > 0
  end
end

describe WinViewModel, "parsing status updates" do

  #TODO: use machinist
  before(:each) do
    @user = User.find_or_create_by_username("megatron")
    @user.email = "megatron@decepticons.com"
    @user.password = "ihateautobots"
    @user.password_confirmation = "ihateautobots"
    @user.save!
  end


  def get_win(status)
    WinViewModel.new({:body=>status, :username=>"megatron"}).to_win
  end

  it "can hand plural and singular nouns" do
    get_win("ran 3 miles").noun.should == "miles"
    get_win("ran 1 mile").noun.should == "miles"
  end

  it "can handle the word a" do
    get_win("ran a mile").amount.should == 1
  end

  it "can handle all single digit numbers" do
    get_win("ran one mile").amount.should == 1
    get_win("ran two miles").amount.should == 2
    get_win("ran three miles").amount.should == 3
    get_win("ran four miles").amount.should == 4
    get_win("ran five miles").amount.should == 5
    get_win("ran six miles").amount.should == 6
    get_win("ran seven miles").amount.should == 7
    get_win("ran eight miles").amount.should == 8
    get_win("ran nine miles").amount.should == 9
    get_win("ran ten miles").amount.should == 10
  end

  it "can handle floats" do
    get_win("ran 9.1 miles").amount.should == 9.1
  end

  it "removes the word i" do
    get_win("i ran 8 miles").verb.should == "ran"
  end
end
