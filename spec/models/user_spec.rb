require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
	it "can be persisted with valid attributes" do
		valid_hash = {
			:email 							=> "test@test.com",
			:password						=> "megatron",
			:password_confirmation	=> "megatron",
		}
		user = User.new valid_hash
		user.username = "megatron"
		user.save!.should == true
		user.id.should be > 0
		user.username.should == "megatron"
		user.email.should == "test@test.com"		
	end
end
