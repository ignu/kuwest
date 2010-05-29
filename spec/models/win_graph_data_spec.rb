require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module WinGraphDataSpecHelpers
  def add_win(hash)
    win = Win.new hash
    win.user = @user
    win.save!
  end
  
  def activities
    @win_graph_data.activities
  end
  
  def count_for(phrase)
    activities.count {|a| a.phrase == phrase }
  end
  
  def activity_with_phrase(phrase)
    activity = @win_graph_data.activities.select {|a| a.phrase == phrase}
    activity.count.should == 1  
    return activity[0]
  end
end

describe WinGraphData, "a single activity" do
  include WinGraphDataSpecHelpers

  before do
    @first_day = Time.parse("2010-05-25 02:28:38")
    @user = User.find_or_create_by_username("mrdowns")
    add_win ({:amount=>3, :noun=>"buses", :verb=>"drove", :created_at=>@first_day})
    @win_graph_data = WinGraphData.new @user
  end
  
  it "returns the phrase" do  
    count_for("drove buses").should == 1
  end
  
  it "returns the amount" do
    activity_with_phrase("drove buses").dates[@first_day.to_date].should == 3
  end
end

describe WinGraphData, "multiple activities on the same day" do
  include WinGraphDataSpecHelpers

  before do
    @first_day = Time.parse("2010-05-25 02:28:38")
    @user = User.find_or_create_by_username("mrdowns")
    add_win ({:amount=>3, :noun=>"buses", :verb=>"drove", :created_at=>@first_day})
    add_win ({:amount=>3, :noun=>"torches", :verb=>"froze", :created_at=>@first_day})
    add_win ({:amount=>3, :noun=>"rivers", :verb=>"bridged", :created_at=>@first_day})
    @win_graph_data = WinGraphData.new @user
  end
  
  it "returns all phrases" do
    count_for("drove buses").should == 1
    count_for("froze torches").should == 1
    count_for("bridged rivers").should == 1
    activities.count.should == 3
  end
end

describe WinGraphData, "multiple activities with the same phrase on the same day" do
  include WinGraphDataSpecHelpers
  
  before do
    @first_day = Time.parse("2010-05-25 02:28:38")
    @user = User.find_or_create_by_username("mrdowns")
    add_win ({:amount=>3, :noun=>"buses", :verb=>"drove", :created_at=>@first_day})
    add_win ({:amount=>3, :noun=>"torches", :verb=>"froze", :created_at=>@first_day})
    add_win ({:amount=>5, :noun=>"torches", :verb=>"froze", :created_at=>@first_day})
    @win_graph_data = WinGraphData.new @user    
  end
  
  it "returns distinct phrases" do
    count_for("drove buses").should == 1
    count_for("froze torches").should == 1
    activities.count.should == 2
  end
  
  it "returns amount totals for each phrase" do
    activity_with_phrase("froze torches").dates[@first_day.to_date].should == 8
    activity_with_phrase("froze torches").dates.keys.count.should == 1
  end
end

describe WinGraphData, "multiple activities with the same phrase on different days" do
  include WinGraphDataSpecHelpers
  
  before do
    @first_day = Time.parse("2010-05-25 02:28:38")
    @second_day = Time.parse("2010-05-26 02:28:38")
    @third_day = Time.parse("2010-05-27 02:28:38")
    @user = User.find_or_create_by_username("mrdowns")
    add_win ({:amount=>3, :noun=>"buses", :verb=>"drove", :created_at=>@first_day})
    add_win ({:amount=>3, :noun=>"torches", :verb=>"froze", :created_at=>@first_day})
    add_win ({:amount=>5, :noun=>"torches", :verb=>"froze", :created_at=>@second_day})
    add_win ({:amount=>7, :noun=>"torches", :verb=>"froze", :created_at=>@third_day})
    @win_graph_data = WinGraphData.new @user    
  end
  
  it "returns the min date" do
    activities.min_date.should == @first_day.to_date
  end
  
  it "returns the max date" do
    activities.max_date.should == @third_day.to_date
  end
  
  it "returns a collection of dates for each phrase" do
    activity_with_phrase("froze torches").dates.keys.count.should == 3
  end
  
  it "contains correct amount at each date" do
    activity_with_phrase("froze torches").dates[@first_day.to_date].should == 3
    activity_with_phrase("froze torches").dates[@second_day.to_date].should == 5
    activity_with_phrase("froze torches").dates[@third_day.to_date].should == 7
    activity_with_phrase("froze torches").dates.keys.count.should == 3
  end
  
  it "contains all dates in top level collection" do
    @win_graph_data.dates.count.should == 3
  end
end
