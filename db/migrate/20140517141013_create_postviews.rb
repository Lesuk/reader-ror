class CreatePostviews < ActiveRecord::Migration
  def change
    create_table :postviews do |t|
      t.string :guest_ip
      t.integer :post_id

      t.timestamps
    end
  end
end
