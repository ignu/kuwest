require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Win do

  before(:each) do
    @user = User.find_or_create_by_username("megatron")
    @user.email = "megatron@decepticons.com"
    @user.password = "ihateautobots"
    @user.password_confirmation = "ihateautobots"    
    @user.save!
  end

  it "can be persisted with valid attributes" do
    valid_hash = {:amount=>3, :noun=>"Miles", :verb=>"ran"}
    win = Win.new valid_hash
    win.user = @user;
    win.save!.should ==  true
    win.id.should be > 0
  end
  
  it "can be persisted from a win view model" do
    win_view_model = WinViewModel.new(:body=>"ran 3 miles", :username=>"megatron")
    win = win_view_model.to_win
    win.verb.should == "ran"
    win.amount.should == 3
    win.noun.should == "miles"
    win.save!.should ==  true
    win.id.should be > 0
  end
end

describe WinViewModel do
  it "can be initialized from hash" do
    win_view_model = WinViewModel.new({:body=>"ran 3 miles", :username=>"ignu"})
    win_view_model.body.should == "ran 3 miles"
    win_view_model.username.should == "ignu"
  end
end

describe WinGraphViewModel do
  before(:each) do
    @user = User.find_or_create_by_username("mrdowns")
    win = Win.new {:amount=>3, :noun=>"Miles", :verb=>"ran"}
    win.user = @user
    win.save!
  end

  it "returns all distinct phrases for a user" do  
    win_graph_view_model = WinGraphViewModel.new(user)
  end
end

