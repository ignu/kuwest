class User < ActiveRecord::Base

  has_many :wins
	attr_accessible :email, :password, :password_confirmation
	validates_uniqueness_of :username

  has_attached_file :photo,
          :styles => {
            :thumb   => "24x24",
            :medium  => "64x64"
           },
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
