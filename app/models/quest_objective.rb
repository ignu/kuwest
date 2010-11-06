class QuestObjective < ActiveRecord::Base

  belongs_to :quest
  belongs_to :objective

  def initialize(attributes=nil)
    if(attributes && attributes[:amount])
      amount = attributes[:amount]
      attributes[:target1] = amount/10
      attributes[:target2] = amount/4
      attributes[:target3] = amount/2
    end
    super(attributes)
  end

  def self.from_objective(objective, quest)
    rv = self.new()
    rv.noun = objective.noun
    rv.verb = objective.verb
    rv.amount = objective.amount
    rv.objective = objective
    rv.target1 = rv.amount/10
    rv.target2 = rv.amount/4
    rv.target3 = rv.amount/2
    rv.completed = 0
    rv
  end

  def percent
    ((self.completed / current_target.to_f) *100).to_i
  end

  def process_update(win)
    self.completed = self.completed + win.amount
  end

  def to_s
    "#{self.verb} #{self.current_target} #{self.noun}"
  end

  def current_target
    return self.target1 unless self.completed > self.target1
    return self.target2 unless self.completed > self.target2
    return self.target3 unless self.completed > self.target3
    amount
  end

end
