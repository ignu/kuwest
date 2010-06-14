require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TwitterDownloader do 

  describe "tweet processing" do
   
    it  "should ignore the username"  do 
      status = TwitterDownloader.parse(OpenStruct.new({:text=>"@kuwest ate three tacos", :from_user=>"ignu"}))
      status.noun.should == "tacos"
      status.user.save!
    end
  end
end
