require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestDefinition do

  subject { QuestDefinition.make  }
  let     (:quest_definition) { QuestDefinition.build }

  before do
    subject.objectives.make
  end

  it "can save a valid quest" do
    subject.save.should == true
  end

  it "can have an objective" do
    subject.objectives.length.should > 0
  end

  describe "#objective" do

    before do
      quest_definition.objective = "run 5 miles"
      quest_definition.save
    end

    it "creates an objective on save" do
      objective = quest_definition.objectives.first
      objective.noun.should == "miles"
      objective.verb.should == "run"
      objective.past_tense_verb.should == "ran"
    end

    it "is nil after save" do
      quest_definition.objective.should == nil
    end

  end
end
