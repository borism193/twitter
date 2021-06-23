class AddTweetIdToTweet < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :retweet_id, :integer, unique: true
    add_index :tweets, :retweet_id, unique: true
  end
end
