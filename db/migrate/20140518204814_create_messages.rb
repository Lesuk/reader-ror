class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recepient_id
      t.string :subject
      t.text :body
      t.integer :read
      t.timestamps
    end
  end
end
