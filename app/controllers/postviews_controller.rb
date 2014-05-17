class PostviewsController < ApplicationController

	def new
		@view = Postview.new
	end

	def create
		@view = Postview.new(view_params)
		@view.post_id = Article.friendly.find(params[:id])
		@view.save!
	end

private
	def view_params
		params.require(:view).permit(:gues_id, :article_id)
	end

end
