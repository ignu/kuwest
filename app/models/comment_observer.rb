class CommentObserver < ActiveRecord::Observer
  def before_save(comment)
    return if comment.id
    user = comment.user || User.load(comment.user_id)
    raise "Could not find user for comment" if user.nil?
    user.xp ||= 0 
    user.xp = user.xp+5
    user.save!
  end
end
