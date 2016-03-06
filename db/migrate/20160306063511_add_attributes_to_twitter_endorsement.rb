class AddAttributesToTwitterEndorsement < ActiveRecord::Migration
  def change
    add_column :endorsement_tweets, :profile_image_url, :string
    add_column :endorsement_tweets, :url, :string
  end
end
