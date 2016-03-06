class CreateEndorsementTweets < ActiveRecord::Migration
  def change
    create_table :endorsement_tweets do |t|
      t.bigint :tweet_id
      t.text :text
      t.integer :followers
      t.string :author

      t.timestamps null: false
    end
  end
end
