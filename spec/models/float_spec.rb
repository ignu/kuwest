require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Float do
  describe "pretty" do
    it "can print with no decimal points where there are no decimals" do
      3.0.pretty.should == "3"
      12.0.pretty.should == "12"
    end
    
    it "can print 1 decimal place" do
      3.1.pretty.should == "3.1"
      4.16.pretty.should == "4.2"
      14.12.pretty.should == "14.1"
    end

  end 
end
