require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestDefinitionsController do

  include SessionHelpers

  describe "when a user defines a quest" do 

    before(:each) do
      p = {
            :quest_definition => { 
                :name          => "Run 100 Miles",
                :description   => "Run 100 Miles",
                :objective     => "run 100 miles" }
          }
      @current_user = signin_as('len@kuwest.com', 'len', '111111')
      post(:create, p) 
    end

    it "assigns that quest to the user" do
      @current_user.quests.first.quest_definition.name.should == "Run 100 Miles"
    end

  end

end
