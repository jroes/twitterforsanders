class AddTweetedAtToEndorsementTweets < ActiveRecord::Migration
  def change
    add_column :endorsement_tweets, :tweeted_at, :timestamp
  end
end
