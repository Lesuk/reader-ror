class Article < ActiveRecord::Base
	has_many :categorizes
	has_many :categories, through: :categorizes
	belongs_to :user

	default_scope -> {order('created_at DESC')}
	scope :by_author, -> (user_id) { where user_id: user_id }

	validates :title, :content, presence: true

	def self.categorized_with(name)
		Category.find_by_name!(name).articles
	end

	def self.users_articles(user)
		User.find_by_login!(user).articles		
	end

	def self.category_counts
		Category.select("categories.*, count(categorizes.category_id) as count").
			joins(:categorizes).group("categorizes.category_id")
	end

	def category_list
		categories.map(&:name).join(", ")
	end

	def category_list=(names)
		self.categories = names.split(",").map do |n|
			Category.where(name: n.strip).first_or_create!
		end
	end

end
