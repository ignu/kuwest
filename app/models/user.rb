class User < ActiveRecord::Base
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
    find $1
	end
end
