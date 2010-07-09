class UserObserver < ActiveRecord::Observer

  def before_save(user)
    return if user.id
    user.xp = 10
  end 

end

