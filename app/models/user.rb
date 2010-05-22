class User < ActiveRecord::Base
  has_many :wins
  
	devise 	:database_authenticatable,
					:registerable,
					:recoverable,
					:rememberable,
					:trackable,
					:validatable

	attr_accessible :email, :password, :password_confirmation

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

end
