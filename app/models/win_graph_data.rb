class WinGraphData
  attr_accessor :activities, :dates

  def initialize (user)
    #don't quite know why, but this range gives us the last seven days
    latest_date_with_activity = Win.maximum(:created_at, :conditions => ['user_id = ?', user.id])
    latest_date_with_activity = Time.now if latest_date_with_activity.nil?
    start_date = latest_date_with_activity - 6.days
  
    wins = Win.all(:conditions => {
      :created_at => (start_date.midnight)..(Time.now + 1.minute),
      :user_id => user.id 
      })
    
    wins = Array.new if wins.nil?
    
    distinct_phrases = wins.collect{|w| phrase_for w}.to_a.uniq
    
    @activities = Graph::Activities.new
    distinct_phrases.each do |phrase|
      matching_wins = wins.select{|win| phrase == phrase_for(win)}
      activity = Graph::Activity.new({:phrase=>phrase})
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
    if not @activities.min_date.nil? then
      (@activities.min_date..@activities.max_date).each do |date|
        @dates << date
      end
    end
  end
  
  def as_json(options={})
    dates = (@activities.min_date..@activities.max_date).collect{|d| d }
    
    return { 
      :activities => @activities.collect do |a| 
        { :phrase => a.phrase, :amounts => dates.collect { |date| a.dates[date] or 0 } } 
      end,
      :dates => dates.collect {|d| d.strftime("%b %d") }
    }
  end
  
  private
  
  def phrase_for(win)
    return "#{win.verb} #{win.noun}"
  end
  
  def total_amount_for(wins, date)
    wins_on_date = wins.select{|win| win.created_at.to_date == date}
    wins_on_date.inject(0) {|sum, w| sum + w.amount.to_i}
#    return wins_on_date.collect{|w| w.amount}.inject {|a,x| a + x}
  end
end

module Graph
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
end
