class QuestDefinition < ActiveRecord::Base
  attr_accessor :objective
  has_many :objectives
  belongs_to :user
  has_friendly_id :name, :use_slug => true
  before_save :parse_objective

  def start_quest(user, why)
    quest = Quest.new
    quest.quest_definition = self
    quest.user = user
    self.objectives.each do |o|
      quest.quest_objectives << QuestObjective.from_objective(o, quest)
    end
    quest.why = why unless why.nil?
    user.quests << quest
    quest
  end

  private

  def parse_objective
    return if self.objective.nil?
    o = Objective.from(Activity.new(self.objective))
    self.objectives << o
    self.objective = nil if o.save
  end

end
