class User < ActiveRecord::Base

  has_many :wins
	attr_accessible :username, :photo, :email, :password, :password_confirmation
	validates_uniqueness_of :username
  validates_presence_of :username
  
  has_attached_file :photo,
          :storage        => :s3,
          :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
          :path           => ":attachment/:id/:style.:extension"
  
  devise 	:database_authenticatable,
					:registerable,
					:recoverable,
					:rememberable,
					:trackable,
					:validatable

end
