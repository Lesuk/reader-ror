require "babosa"
class Article < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :title, use: :slugged
	has_many :categorizes
	has_many :categories, through: :categorizes
	has_many :comments
	belongs_to :user

	default_scope -> {order('created_at DESC')}
	scope :by_author, -> (user_id) { where user_id: user_id }
	scope :published, lambda { where("articles.published_at IS NOT NULL") } # I don't use it now

	validates :title, :content, :user_id, presence: true

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

	def normalize_friendly_id(input)
	    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
	end

	def published?
		publish_date.present?
	end

	def owned_by?(owner)
		return false unless owner.is_a?(User)
		user == owner
	end

end
