class Objective < ActiveRecord::Base
  has_one :quest
  def calculate_past_tense  
    self.past_tense_verb = Verbs::Conjugator.conjugate verb.to_sym, :tense => :past, :person => :second, :plurality => :singular, :aspect => :perfective
  end
end
