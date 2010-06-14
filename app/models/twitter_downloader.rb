class TwitterDownloader

  def self.sync
      
  end

  def self.parse(tweet)
    body = tweet.text.gsub!(/@kuwest /, '')  
    WinViewModel.new({:body=>body, :username => tweet.from_user}).to_win
   end

end
