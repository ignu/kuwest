class User < ActiveRecord::Base
  has_many :wins
  
	acts_as_authentic do |c|
	end
	
	def persistence_token #HACK
	  @perishable_token
  end
  
  def persistence_token=(value) 
    @perishable_token=value
  end
  
  def persistence_token_changed?
    perishable_token_changed?
  end

	def self.find_by_persistence_token token
  	token =~ /^(.+)asdf$/
    find token 
	end
  
  def self.find_or_create_by_username(login)  
   hack_for_authlogic_defaults(find_or_create_by_login(login))
  end
  
  def self.hack_for_authlogic_defaults(user)
    puts "HACK FOR FIND BY USERNAME"   
    user.email = "megatron@decepticons.com"
    user.password = user.password_confirmation = "abc123!"
    user.persistance_token = "123234232"
    user.login_count = user.failed_login_count = 0
    user.current_login_at = user.last_login_at = user.last_request_at = DateTime.new
    user.last_login_ip = user.current_login_ip = "127.0.0.1"
    user
  end
end
