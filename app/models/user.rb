require 'digest/md5'

class User < ActiveRecord::Base

  has_many :wins
  has_many :quest_definitions
  has_many :quests
  has_many :comments

  has_many :follows, :class_name => 'Following', :foreign_key => "follower_id"
  has_many :followed_by, :class_name => 'Following', :foreign_key => "following_id"

  has_many :followers, :through => :followed_by
  has_many :followings, :through => :follows

  attr_accessible :username, :photo, :email, :password, :password_confirmation
  attr_accessible :first_name, :last_name, :public_name, :twitter_name, :url, :xp, :allow_email
  has_friendly_id :username
  validates_uniqueness_of :username
  validates_presence_of :username
  @@thumb, @@small, @@profile = "48x48#", "73x73#", "248z248"
  before_save :ensure_password_hack_for_twitter_accounts

  has_attached_file :photo,
          :storage        => :s3,
          :s3_credentials => "#{Rails.root}/config/s3.yml",
          :path           => ":attachment/user/:id/:style.:extension",
          :styles         =>  {
                              :thumb=> "48x48#",
                              :small  => "73x73#",
                              :profile => "248x248>" },
          :default_url    => "/images/:attachment/defaults/user_avatar_:style.gif"

  process_in_background :photo

  def ensure_password_hack_for_twitter_accounts
    if (self.password.nil? || self.password.length <1)
      self.password = self.password_confirmation = 'abc12345##'
    end
  end

  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable

  def to_s
    self.username
  end

  def gravatar_image(email)
    # get the email from URL-parameters or what have you and make lowercase
    email_address = email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    "http://www.gravatar.com/avatar/#{hash}?d=http://kuwest.com/images/photos/defaults/user_avatar_thumb.gif"
  end

  def the_photo(size)
    photo.exists? ? photo.url(size) : gravatar_image(email)
  end

  def following?(user)
    followings.include?(user)
  end

  def level
    return 0 if not xp
    User.xp_limits.each_index do |i|
      return i-1 if User.xp_limits[i] >= xp
    end
  end

  def level_progress
    return 0 if xp.nil?
    extra_xp = xp - User.xp_limits[level]
    extra_xp/(User.xp_limits[level+1]-User.xp_limits[level]).to_f
  end

  class << self
    def xp_limits
      [-1, 15, 20, 45, 80, 110, 150, 200, 275, 375, 500, 750, 1000, 1275, 1600, 1900, 2300]
    end

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
