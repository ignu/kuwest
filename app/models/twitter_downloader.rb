class TwitterDownloader

  class << self
    @@last_tweet = 0;
    def twitter_name
      "@kuwest"
    end

    def sync
      tweets = unprocessed_tweets
        tweets.each do |tweet|
          parse tweet
        end
      store_last_tweet tweets
    end

    def store_last_tweet (tweets)
      setting = Settings.find_or_create_by_name("last_tweet")
      last_tweet = tweets.to_a.first #tweets come from twitter in reverse order
      unless last_tweet.nil?
        @@last_tweet = last_tweet.id
        setting.value = last_tweet.id
        setting.save!
      end
    end

    def parse(tweet)
      body = tweet.text.gsub!(/#{twitter_name} /, '')
      begin
        win = WinViewModel.new({:body=>body, :username => tweet.from_user}).to_win
        win.save!
      rescue
        puts " ********* couldn't parse #{body}"
      end
      win
     end

    def unprocessed_tweets
       tweets = []
       results = Twitter::Search.new(twitter_name).since(@@last_tweet).per_page(50).page(1).fetch["results"]
       unless results.nil?
         tweets += results
       end
       return tweets
    end

    def __RESET__
      @@last_tweet = nil
    end

    def __RELOAD__
      __RESET__
      Win.delete_all
      Settings.delete_all
      sync
    end

  end
end
