class AddOembedToTwitterEndorsement < ActiveRecord::Migration
  def change
    add_column :endorsement_tweets, :oembed, :string
  end
end
