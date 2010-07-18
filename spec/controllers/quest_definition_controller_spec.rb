require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestDefinitionsController do

  describe "when a user defines a quest" do 

    before(:each) do
      p = {
            :quest_definition => { 
                :description    => "Run 100 Miles"
                },
             :quest_objectives => { :description => "run 100 miles" }
          }
      @current_user = signin_as('len@kuwest.com', 'len', '111111')
      post(:create, p) 
    end

    it "assigns that quest to the user" do
      pending
    end

    it "asks that user if they are going to complete that quest" do
      pending
    end

    it "asks the user for a description of why they want to finish the quest" do
      pending
    end

    it "breaks up the objective into three pieces" do
      pending
    end

  end

end
