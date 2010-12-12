class Objective < ActiveRecord::Base
  has_one :quest_definition

  def calculate_past_tense
    self.past_tense_verb = Verbs::Conjugator.conjugate verb.to_sym, :tense => :past, :person => :second, :plurality => :singular, :aspect => :perfective
  end

  def self.from(activity)
    o = Objective.new(:noun=>activity.noun, :verb=>activity.verb,
      :amount=>activity.amount)
    o.calculate_past_tense
    o
  end

  def to_s
    "#{self.verb} #{self.amount} #{self.noun}"
  end
end
