
Then /^that Quest should be added to my quest_definitions$/ do
  @current_user.quests.length.should == 1 
  @current_user.quests.first.objectives.first.noun.should == "miles"
end

