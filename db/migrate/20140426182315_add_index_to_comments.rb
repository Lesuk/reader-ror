class AddIndexToComments < ActiveRecord::Migration
  def change
  	add_index :comments, :user_id
  	add_index :microposts, :to_id
  end
end
