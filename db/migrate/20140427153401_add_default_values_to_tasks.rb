class AddDefaultValuesToTasks < ActiveRecord::Migration
  def change
  	change_column :tasks, :completed, :boolean, :default => false
  	change_column :tasks, :priority, :integer, :default => 0
  end
end
