class ChangeDateFormatInArticles < ActiveRecord::Migration
  def change
  	change_column :articles, :publish_date, :datetime
  end
end
