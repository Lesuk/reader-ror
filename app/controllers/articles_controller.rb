class ArticlesController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_action :set_article, only: [:show]

	def index
		@name = ""
		if params[:category]
			@articles = Article.categorized_with(params[:category])
		elsif params[:author]
			#@articles = Article.users_articles(params[:author])
			@articles = Article.by_author(params[:author])
			@name = "by " + User.find_by_id(params[:author]).name
		else			
			@articles = Article.all
		end
	end

	def show
		@commentable = @article
		@comments = @commentable.comments
		#@comment = Comment.new
	end

	def new
		@article = Article.new
	end

	def create
		@article = current_user.articles.new(article_params)
		#@article.user_id = current_user.id
		if @article.save
			flash[:success] = "New article has been created."
			micro_post_content = view_context.link_to(@article.title, @article)
			micropost = current_user.microposts.build(content: micro_post_content)
			micropost.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
		@article = current_user.articles.friendly.find(params[:id])
	end

	def update
		@article = current_user.articles.friendly.find(params[:id])
		if @article.update_attributes(article_params)
			redirect_to @article
			flash[:success] = "Article updated"
		else
			render 'edit'
		end
	end

	def destroy
		@article = current_user.articles.friendly.find(params[:id])
		@article.destroy
		flash[:success] = "Article deleted"
		redirect_to articles_url
	end


	private

		def set_article
			@article = Article.friendly.find(params[:id])
		end

		def article_params
			params.require(:article).permit(:title, :content, :publish_date, :category_list)
		end

end
