class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.string :note
      t.boolean :completed
      t.integer :priority

      t.timestamps
    end
    add_index :tasks, :user_id
  end
end
