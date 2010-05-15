require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Win do

  it "can be persisted with valid attributes" do
    valid_hash = {:amount=>3, :noun=>"Miles", :verb=>"ran"}
    win = Win.new valid_hash
    win.save!.should ==  true
    win.id.should be > 0
  end
end
