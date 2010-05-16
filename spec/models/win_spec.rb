require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Win do

  before(:each) do
    @user = User.find_or_create_by_login("megatron")
    @user.email = "megatron@decepticons.com"
    @user.password = @user.password_confirmation = "abc231&"
    @user.persistance_token = "123234232"
    @user.login_count = @user.failed_login_count = 0
    @user.current_login_at = @user.last_login_at = @user.last_request_at = DateTime.new
    @user.last_login_ip = @user.current_login_ip = "127.0.0.1"
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
    win_view_model = WinViewModel.new(:body=>"ran 3 miles", :username=>"ignu")
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

