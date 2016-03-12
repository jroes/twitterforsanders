class TwitterEndorsementCollector
  def initialize(since_id = nil)
    @since_id = since_id || EndorsementTweet.latest_tweet.try(:tweet_id) || 1
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    end
  end

  def collect(query)
    Rails.logger.info "collecting tweets for '#{query}'..."
    tweets = @client.search(query, since_id: @since_id, count: 100)
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

  def collect_until_empty(query)
    collected = collect query
    while collected > 0
      collected = collect query
    end
  end

  def collect_for_queries(queries)
    queries.each do |query|
      collect_until_empty(query)
    end
  end

  # todo: streaming
end
