class QuestObjective < ActiveRecord::Base

  belongs_to :quest
  belongs_to :objective

  def initialize(attributes=nil)
    if(attributes && attributes[:amount])
      amount = attributes[:amount]
    end
    super(attributes)
  end

  def self.from_objective(objective, quest)
    rv = self.new()
    rv.noun = objective.noun
    rv.verb = objective.verb
    rv.amount = objective.amount
    rv.objective = objective
    rv.completed = 0
    rv
  end

  def target1
    self.amount/10
  end

  def target2
    self.amount/4
  end

  def target3
    self.amount/2
  end

  def remaining_text
    "#{self.current_target - self.completed} #{noun.downcase} remaining"
  end

  def percent
    return 100 if self.completed > self.current_target
    ((self.completed / current_target.to_f) *100).to_i
  end

  def process_update(win)
    self.completed = self.completed + win.amount
  end

  def to_s
    "#{self.verb} #{self.current_target} #{self.noun}"
  end

  def current_target
    return self.target1 if self.completed.nil?
    return self.target1 unless self.completed > self.target1
    return self.target2 unless self.completed > self.target2
    return self.target3 unless self.completed > self.target3
    amount
  end

end
