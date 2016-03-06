class EndorsementTweet < ActiveRecord::Base
  def self.latest_tweet
    order('tweet_id desc').first
  end
end
