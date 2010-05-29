class WinGraphData
  attr_accessor :activities, :dates

  def initialize (user)
    wins = Win.find_all_by_user_id user.id
    
    distinct_phrases = wins.collect{|w| phrase_for w}.to_a.uniq
    
    @activities = Activities.new
    distinct_phrases.each do |phrase|
      matching_wins = wins.select{|win| phrase == phrase_for(win)}
      activity = Activity.new({:phrase=>phrase})
      dates = matching_wins.collect{|win| win.created_at.to_date}
      dates.each do |date|
        activity.add_date date, total_amount_for(matching_wins, date)
      end
      @activities << activity
    end
    
    dates = wins.collect {|w| w.created_at.to_date}
    @activities.min_date = dates.min
    @activities.max_date = dates.max
    
    @dates = Array.new
    (@activities.min_date..@activities.max_date).each do |date|
      @dates << date
    end
  end
  
  private
  
  def phrase_for(win)
    return "#{win.verb} #{win.noun}"
  end
  
  def total_amount_for(wins, date)
    wins_on_date = wins.select{|win| win.created_at.to_date == date}
    return wins_on_date.collect{|w| w.amount}.inject {|a,x| a + x}
  end
end

class Activities < Array
  attr_accessor :min_date, :max_date
end

class Activity
  attr_accessor :phrase, :dates

  def initialize (hash)
    @phrase = hash[:phrase]    
    @dates = Hash.new
  end
  
  def add_date(date, total)
    @dates[date] = total
  end
end
