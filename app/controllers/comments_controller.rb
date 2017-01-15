class CommentsController < ApplicationController
	def create
		post = Post.find(params[:post_id])
		comment = post.comments.new(params[:comment])
		comment.save
		flash[:notice] = "Comment saved!"
		redirect_to post_path(post)
	end
end
