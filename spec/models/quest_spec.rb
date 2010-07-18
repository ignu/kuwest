require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestDefinition do 
  let (:objective) { Objective.new({
    :name => "run 1000 miles", 
    :amount => 2,
    :verb => "run",
    :noun => "miles" 
  })}
  let (:quest_definition) { QuestDefinition.new({
    :name => "Quest", 
    :description => "Pretty cool quest",
    :user => User.first
  })}

  it "can save a valid quest" do 
    quest_definition.save
    quest_definition.id.should > 0
  end

  it "can have an objective" do 
    quest_definition.save
    quest_definition.id.should > 0
    objective.quest_definition = quest_definition
    objective.save
    objective.id.should > 0
    i = quest_definition.id #HACK: this is baffling, if i don't do this i get .id called on null error
    quest_definition = QuestDefinition.find_by_id(i)
    #quest.objectives.first.id.should == objective.id
  end

  it "can create an objective if objective string is set" do 
    quest_definition.objectives.length.should == 0
    quest_definition.objective = "run 5 miles"
    quest_definition.parse_objective
    quest_definition.objectives.length.should == 1
    quest_definition.objectives.first.noun.should == "miles"
    quest_definition.objectives.first.verb.should == "run"
    quest_definition.objectives.first.past_tense_verb.should == "ran"
  end
end



