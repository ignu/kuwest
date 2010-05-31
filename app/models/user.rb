class User < ActiveRecord::Base

  has_many :wins
  has_many :comments

  attr_accessible :username, :photo, :email, :password, :password_confirmation
  attr_accessible :first_name, :last_name, :public_name, :twitter_name, :url
  validates_uniqueness_of :username
  validates_presence_of :username
  
  has_attached_file :photo,
          :storage        => :s3,
          :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
          :path           => ":attachment/user/:id/:style.:extension",
          :styles         =>  {
                              :thumb=> "48x48#",
                              :small  => "72x72>",
                              :profile => "248x248>" },
          :default_url    => "/images/:attachment/defaults/user_avatar_:style.gif"
  
  devise 	:database_authenticatable,
					:registerable,
					:recoverable,
					:rememberable,
					:trackable,
					:validatable
end
