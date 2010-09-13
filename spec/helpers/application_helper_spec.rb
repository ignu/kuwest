require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'action_view/helpers/date_helper'

describe ApplicationHelper do
  
  before(:each) do
    classObject = Class.new{ include ApplicationHelper }
    @helper = classObject.new
    Timecop.freeze(Time.local(2010, 03, 01, 10, 0, 0))
  end
  
  it "shows today for times today" do
    @helper.days_ago(Date.new(2010, 03, 01)).should == "today"
  end
  
  it "shows yesterday for times yesterday" do
    @helper.days_ago(Date.new(2010, 2, 28)).should == "yesterday"
  end
  
  it "shows 2 days ago for times 2 days ago" do
    @helper.days_ago(Date.new(2010, 2, 27)).should == "2 days ago"
  end
  
  it "shows 3 days ago for times 3 days ago" do
    @helper.days_ago(Date.new(2010, 2, 26)).should == "3 days ago"
  end
  
end
