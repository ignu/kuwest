require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TwitterDownloader do 

  describe "tweet processing" do
    before(:all) do 
      @status = TwitterDownloader.parse(OpenStruct.new({:text=>"@kuwest ate three tacos", :from_user=>"ignu"}))
    end

    it  "should ignore the username"  do 
      @status.noun.should == "tacos"
      @status.verb.should == "ate"
      @status.amount.should == 3 
    end


    it "should create a new user from the username" do 
      @status.user.username.should == "ignu"
      @status.user.id.should be > 0
    end

    it "should persist the tweet" do #HACK: doing two things?
      @status.should_not be_new_record
    end
  end

  describe TwitterDownloader, "when synching tweets" do
    before(:all) do
      tweets = MockTweet.create 10
      TwitterDownloader.expects(:unprocessed_tweets).returns(tweets)
      TwitterDownloader.expects(:parse).times(10)
      TwitterDownloader.expects(:store_last_tweet).with(tweets)
    end

    it "should get create messages out of every tweet since last sync" do
      TwitterDownloader.sync 
    end
  end

class MockTweet
 attr_accessor :text, :from_user , :id

 def self.create (number)
   rv = []
   number.times do |i|
     tweet = MockTweet.new
     tweet.id = 100 - i
     tweet.text = "text #{i}"
     tweet.from_user = "user#{i}"
     rv << tweet  
   end
   rv
 end

  end
end
