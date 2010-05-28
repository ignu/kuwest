class WinGraphData
  attr_accessor :activities

  def initialize (user)
    wins = Win.find_all_by_user_id user.id    
    phrases = wins.collect{|w| phrase_for w}.to_a.uniq
    @activities = Array.new
    phrases.each do |phrase|
      phrase_wins = wins.select{|win| phrase == phrase_for(win)}
      date = phrase_wins[0].created_at
      amount = phrase_wins.collect{|w| w.amount}.inject {|a,x| a+x}
      @activities << Activity.new ({:phrase=>phrase, :amount=>amount, :date=>date})
    end
  end
  
  private
  
  def phrase_for(win)
    return "#{win.verb}_#{win.noun}"
  end
end

class Activity
  attr_accessor :phrase, :amount, :date

  def initialize (hash)
    @phrase = hash[:phrase]
    @amount = hash[:amount]
    @date = hash[:date]
  end
end
