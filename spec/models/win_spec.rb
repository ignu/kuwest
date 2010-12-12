require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Win do

  let (:user) { User.make }

  it "can be persisted with valid attributes" do
    valid_hash = {:amount=>3, :noun=>"Miles", :verb=>"ran"}
    win = Win.new valid_hash
    win.user = user;
    win.save!.should ==  true
    win.id.should be > 0
  end
end
