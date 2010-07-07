class Following < ActiveRecord::Base
  belongs_to :follower, :class_name => "User"
  belongs_to :following, :class_name => "User"  
  
  validates_uniqueness_of :following_id, :scope => :follower_id
  
  validate :check_follow_myself
  
  private
  def check_follow_myself
    if follower == following
      errors.add_to_base("You can not follow yourself!")
    end
  end
end