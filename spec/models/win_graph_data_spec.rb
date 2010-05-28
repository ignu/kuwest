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
  
  def win_with_phrase(phrase)
    @win_graph_data.activities.select {|a| a.phrase == phrase}[0]
  end
  
  def count_for(phrase)
    activities.count {|a| a.phrase == phrase }
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
    activities[0].phrase.should == "drove_buses"
  end
  
  it "returns the amount" do
    activities[0].amount.should == 3
  end
  
  it "returns the date" do
    activities[0].date.should == @first_day
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
    count_for("drove_buses").should == 1
    count_for("froze_torches").should == 1
    count_for("bridged_rivers").should == 1
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
    count_for("drove_buses").should == 1
    count_for("froze_torches").should == 1
    activities.count.should == 2
  end
  
  it "returns amount totals for each phrase" do
    win_with_phrase("froze_torches").amount.should == 8
  end
  
  it "returns the same date" do
    win_with_phrase("froze_torches").date.should == @first_day
  end
end
