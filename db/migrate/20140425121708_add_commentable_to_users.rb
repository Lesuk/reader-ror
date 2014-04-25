class AddCommentableToUsers < ActiveRecord::Migration
  def change
  	add_column :comments, :commentable_id, :integer
  	add_column :comments, :commentable_type, :string
  	remove_column :comments, :article_id, :integer
  	add_index :comments, [:commentable_id, :commentable_type]
  end
end
