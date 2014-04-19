class CreateCategorizes < ActiveRecord::Migration
  def change
    create_table :categorizes do |t|
      t.belongs_to :category, index: true
      t.belongs_to :article, index: true

      t.timestamps
    end
  end
end
