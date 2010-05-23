class User < ActiveRecord::Base
  has_many :wins
  
	devise 	:database_authenticatable,
					:registerable,
					:recoverable,
					:rememberable,
					:trackable,
					:validatable

	attr_accessible :email, :password, :password_confirmation
	validates_uniqueness_of :username

end
