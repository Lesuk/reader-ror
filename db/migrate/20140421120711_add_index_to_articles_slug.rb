class AddIndexToArticlesSlug < ActiveRecord::Migration
  def change
  	add_index :articles, :slug, unique: true
  end
end
