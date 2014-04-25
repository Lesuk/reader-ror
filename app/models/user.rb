class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy # dependent: :destroy - micropost буде видалений разом з User
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
	has_many :articles, dependent: :destroy
	has_many :replies, foreign_key: "to_id", class_name: "Micropost"
	#has_many :annotations, through: :articles, source: :comments
	has_many :comments, dependent: :destroy
	before_save {self.email = email.downcase}
	before_create :create_remember_token
	validates :name, presence: true, length: {maximum: 30}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: VALID_EMAIL_REGEX }

	login_regex = /[A-Za-z]+[A-Za-z0-9_]{3,15}/i
	validates :login, presence: true, length: {maximum: 15}, uniqueness: {case_sensitive: false}, format: { with: login_regex }

	has_secure_password
	validates :password, length: {minimum: 6}, unless: :password_is_not_being_updated?

	def User.new_remember_token
	  SecureRandom.urlsafe_base64
	end

	def User.hash(token)
	  Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		#Micropost.from_users_followed_by(self)
		Micropost.from_users_followed_by_including_replies(self)
	end

	def following?(other_user)
		self.relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		self.relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		self.relationships.find_by(followed_id: other_user.id).destroy!
	end

	def send_password_reset
		self.password_reset_token = User.hash(User.new_remember_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def password_is_not_being_updated?
		self.id && self.password.blank?
	end

	def make_dog
		"@#{login}"
	end

	def self.search(search)
		if search
			where('lower(name) LIKE lower(?)', "%#{search}%")
		else
			scoped
		end
	end

	def to_param
		login
	end

  	private
  	
	    def create_remember_token
	      self.remember_token = User.hash(User.new_remember_token)
	    end

end