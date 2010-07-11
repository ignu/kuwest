require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe  "Quest" do 
  let (:objective) { Objective.new({
    :name => "run 1000 miles", 
    :amount => 2,
    :verb => "run",
    :noun => "miles" 
  })}
  let (:quest) { Quest.new({
    :name => "Quest", 
    :description => "Pretty cool quest",
    :user => User.first
  })}

  it "can save a valid quest" do 
    quest.save
    quest.id.should > 0
  end

  it "can have an objective" do 
    quest.save
    quest.id.should > 0
    objective.quest = quest
    objective.save
    objective.id.should > 0
    i = quest.id #HACK: this is baffling, if i don't do this i get .id called on null error
    quest = Quest.find_by_id(i)
    #quest.objectives.first.id.should == objective.id
  end

  it "can create an objective if objective string is set" do 
    quest.objectives.length.should == 0
    quest.objective = "run 5 miles"
    quest.parse_objective
    quest.objectives.length.should == 1
  end
end



