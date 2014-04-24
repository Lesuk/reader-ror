class RemoveNameAndEmailFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :name, :string
  	remove_column :comments, :email, :string
  end
end
