class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments.paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@post = Post.new
		@comment = Comment.new(post_id: params[:post_id])
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:notice] = "#{@post.title} saved!"
			redirect_to posts_path
		else
			render :new
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(params[post_params])
			flash[:notice] = "#{@post.title} updated!"
			redirect_to @post
		else
			render :edit
		end
	end

	def destroy
		post = Post.find(params[:id])
		post.destroy
		flash[:notice] = "#{post.title} has been deleted"
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:title, :body)
	end
end
