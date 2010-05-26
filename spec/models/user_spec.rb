require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:all) do 
    User.delete_all("username='galvatron'")
    Factory(:user)
  end

	it "can be persisted with valid attributes" do
		valid_hash = {
			:email 							=> "test@test.com",
			:password						=> "megatron",
			:password_confirmation	=> "megatron"}

		user = User.new valid_hash
		user.username = "ratbat"
		user.save!.should == true
		user.id.should be > 0
		user.username.should == "ratbat"
		user.email.should == "test@test.com"		
	end

	it {should have_many :wins}
	it {should validate_uniqueness_of :username}
end
