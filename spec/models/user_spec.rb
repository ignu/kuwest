require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
	it "can be persisted with valid attributes" do
		valid_hash = {
			:login 							=> "test",
			:email 							=> "test@test.com",
			:password						=> "megatron",
			:password_confirmation	=> "megatron",
    	:password_salt			=> "qwertywin",
    	:login_count				=> 1,
    	:failed_login_count	=> 0,
    	:last_request_at		=> Time.now,
    	:current_login_at		=> Time.now,
    	:last_login_at			=> Time.now,
    	:current_login_ip		=> "192.168.0.1",
    	:last_login_ip			=> "192.168.0.1"
		}
		user = User.new valid_hash
		user.save!.should == true
		user.id.should.be > 0
	end
end
