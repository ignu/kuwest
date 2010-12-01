require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestObjective do

  let(:quest_objective) { Factory.build(:quest_objective, :amount => 100, :completed=>10) }

  it "creates objectives at 10, 25 and 50%" do
    quest_objective.current_target.should  == 10
    quest_objective.completed = 15
    quest_objective.current_target.should  == 25
    quest_objective.completed = 35
    quest_objective.current_target.should  == 50
    quest_objective.completed = 55
    quest_objective.current_target.should  == 100
  end

  it "shows the amount remaining" do
    quest_objective.completed = 6
    quest_objective.noun = "miles"
    quest_objective.remaining_text.should == "4 miles remaining"
  end

  it "gives a percent of the current progress" do
    quest_objective.completed = 5
    quest_objective.percent.should == 50
    quest_objective.completed = 34.2
    quest_objective.percent.should == 68
    quest_objective.completed = 0
    quest_objective.percent.should == 0
    quest_objective.completed = 100
    quest_objective.percent.should == 100
    quest_objective.completed = 109
    quest_objective.percent.should == 100
  end

  describe "processing wins" do
    it "should update the completed amount correctly" do
      quest_objective.completed=2
      win = Win.new({:amount=>5})
      quest_objective.process_update(win)
      quest_objective.completed.should == 7
    end
  end

end

