require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Win do

  #TODO: use machinist
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
end
