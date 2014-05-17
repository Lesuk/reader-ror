class RenamePostId < ActiveRecord::Migration
  def change
  	rename_column :postviews, :post_id, :article_id
  	add_index :postviews, :article_id
  end
end
