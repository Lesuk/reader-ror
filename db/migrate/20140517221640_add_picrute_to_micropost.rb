class AddPicruteToMicropost < ActiveRecord::Migration
  def change
  	add_column :microposts, :mpost_picrute, :string
  	add_column :microposts, :repost_author, :integer
  	add_column :microposts, :mtitle, :string
  end
end
