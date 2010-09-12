class WinObserver < ActiveRecord::Observer
  def before_save(win)
    add_xp(win.user || User.load(win.user_id), 3) unless win.id
  end 

  def add_xp(user, xp)
    raise "Could not find user for status update" if user.nil?
    user.xp ||= 0 
    user.xp = user.xp+xp
    user.save!
  end

  def check_wins(win)
    win.user.quest.quest_objectives.each do |o|
      o.process_update(win)
    end
  end
end
