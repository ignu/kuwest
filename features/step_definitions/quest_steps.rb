
Then /^that Quest should be added to my quest_definitions$/ do
  @current_user.quests.length.should == 1 
  @current_user.quests.first.objectives.first.noun.should == "Miles"
end

Then /^I should have the quest definition "([^\"]*)"$/ do |desc|
  @current_user.quest_definitions.first.name.should == desc
end

Then /^I should have the quest "([^\"]*)"$/ do |name|
  @current_user.quests.first.quest_definition.name.should == name 
end

Then /^my quest definition should have the objective "([^\"]*)"$/ do |name|
  @current_user.quest_definitions.first.objectives.first.to_s.should == name
end

Then /^my objectives should contain "([^\"]*)"$/ do |objective|
  @current_user.quests.first.quest_objectives.length.should == 1
  @current_user.quests.first.quest_objectives.to_s.should == objective
end


