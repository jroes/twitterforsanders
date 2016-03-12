class TwitterEndorsementCollector
  def initialize(since_id = nil)
    @since_id = since_id || EndorsementTweet.latest_tweet.try(:tweet_id) || 1
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    end
  end

  def collect
    Rails.logger.info "collecting tweets..."
    tweets = @client.search("I endorse @BernieSanders OR I endorse Bernie Sanders", since_id: @since_id, count: 100)
    tweets_collected = 0
    tweets.each do |tweet|
      next if tweet.retweet?
      EndorsementTweet.find_or_create_by(tweet_id: tweet.id) do |endorsement_tweet|
        endorsement_tweet.author = tweet.user.screen_name
        endorsement_tweet.text = tweet.full_text
        endorsement_tweet.profile_image_url = tweet.user.profile_image_url.to_s
        endorsement_tweet.followers = tweet.user.followers_count
        endorsement_tweet.tweeted_at = tweet.created_at
        endorsement_tweet.url = tweet.url.to_s
        endorsement_tweet.oembed = @client.oembed(tweet.id, hide_media: true, hide_thread: true, omit_script: true).html.html_safe
        tweets_collected += 1
      end
    end
    Rails.logger.info "collected #{tweets_collected} tweets"
    tweets_collected
  rescue Twitter::Error::TooManyRequests => error
    Rails.logger.info "rate limit reached, retrying in #{error.rate_limit.reset_in + 1}"
    sleep error.rate_limit.reset_in + 1
    retry
  end

  def collect_until_empty
    collected = collect
    while collected > 0
      collected = collect
    end
  end

  # todo: streaming
end
