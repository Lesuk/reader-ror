class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.date :publish_date
      t.integer :user_id

      t.timestamps
    end
  end
end
