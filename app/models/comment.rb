class Comment < ActiveRecord::Base
	belongs_to :article
	belongs_to :user

	validates :body, presence: true
	#validate :article_should_be_published

	after_create # :make_micropost - Make comment as micropost and show it to author page

	def article_should_be_published
		errors.add(:article_id, "is not publishe yet") if article && !article.published?
	end
end
