class CommentsController < ApplicationController
	before_action :load_article#, except: :destroy

	def create
		@comment = @article.comments.new(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			respond_to do |format|
				format.html { redirect_to @article, flash[:success] = "Comment added" }
				format.js
			end
		else
			respond_to do |format|
				format.html {redirect_to @article}
				format.js {render 'fail_create.js.erb'}
			end
		end
	end

	def destroy
		#@article = current_user.articles.friendly.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to @article, flash[:success] = "Comment deleted" }
			format.js
		end
	end


	private

		def load_article
			@article = Article.friendly.find(params[:article_id])
		end

		def comment_params
			params.require(:comment).permit(:body)
		end

end