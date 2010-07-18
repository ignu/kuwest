class QuestObjective < ActiveRecord::Base
  belongs_to :quest
  belongs_to :objective


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

  def to_s
    "#{self.verb} #{self.current_target} #{self.noun}"
  end

  def current_target
    self.target1     
  end

end
