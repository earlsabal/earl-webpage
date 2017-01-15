class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(params[comment_params])
		@comment.save
		flash[:notice] = "Comment saved!"
		redirect_to post_path(@post)
	end

	private
	def comment_params
		params.require(:comment).permit(:author, :text)
	end
end
