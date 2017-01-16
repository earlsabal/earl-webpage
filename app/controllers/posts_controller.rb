class PostsController < ApplicationController
	before_filter :login_required, :except => [:index, :show]

	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 10)
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
		if @post.update_attributes(post_params)
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

	def login_required
  		unless current_admin
    		flash[:error] = 'Only logged in admins an access this page.'
    		redirect_to posts_path
  		end
	end
end
