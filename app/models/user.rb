class User < ActiveRecord::Base

  has_many :wins
  has_many :comments

  attr_accessible :username, :photo, :email, :password, :password_confirmation
  attr_accessible :first_name, :last_name, :public_name, :twitter_name, :url, :xp
  validates_uniqueness_of :username
  validates_presence_of :username
  
  has_attached_file :photo,
          :storage        => :s3,
          :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
          :path           => ":attachment/user/:id/:style.:extension",
          :styles         =>  {
                              :thumb=> "48x48#",
                              :small  => "73x73#",
                              :profile => "248x248>" },
          :default_url    => "/images/:attachment/defaults/user_avatar_:style.gif"

  process_in_background :photo
  
  devise 	:database_authenticatable,
					:registerable,
					:recoverable,
					:rememberable,
					:trackable,
					:validatable  
  
  class << self

    def populate(user)
      user.password_confirmation = user.password = "abc123"
      user.email = "twitter_#{user.username}@twitter.com"
      user.save!
      user
    end

    # This will generate all the needed methods for devise
    def find_or_generate_by_username(username)
      user = find_or_create_by_username(username) 
      populate(user) if (user.new_record?)
      user
    end

 # TODO:dunno why this doesn't work
 #  def find_or_create_by_username_with_populate(username)
 #    user = find_or_create_by_username_without_populate(username)
 #    user.password_confirmation = user.password = "abc123"
 #    user
 #  end

 #  alias_method_chain :find_or_create_by_username, :populate
  end

end
