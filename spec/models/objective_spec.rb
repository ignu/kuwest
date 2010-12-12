require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Objective" do

  it "should save past tense verb" do
    objective = Objective.new({:verb=>"run"})
    objective.calculate_past_tense
    objective.past_tense_verb.should == "ran"
  end

end
