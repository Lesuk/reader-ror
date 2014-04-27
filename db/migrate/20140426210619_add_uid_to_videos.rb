class AddUidToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :uid, :string
  	add_index :videos, :uid
  end
end
