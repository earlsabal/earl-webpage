class PostsController < ApplicationController
	def index
		@posts = Posts.paginate :page => params[:page], :per_page => 10
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments.paginate :page => params[:page], :per_page => 10, :order => 'created_at ASC'
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new params[:post]
		if @post.save
			flash[:notice] = "#{@post.title} saved!"
			redirect_to @post
		else
			render :new
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(params[:post])
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
end
