class AddRetweetIdToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :retweet_id, :integer
  	add_index :microposts, :retweet_id
  end
end
