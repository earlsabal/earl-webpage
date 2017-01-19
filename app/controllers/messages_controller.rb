class MessagesController < ApplicationController
	def index
		@messages = Message.paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@message = Message.new
	end

	def create
		@message = Message.new(message_params)
		if @message.save
			flash[:notice] = "Message Sent!"
			redirect_to "/about"
		else
			render :new
		end
	end

	def destroy
		message = Message.find(params[:id])
		message.destroy
		flash[:notice] = "#Message has been deleted"
		redirect_to messages_path
	end

	private
	def message_params
		params.require(:message).permit(:name, :email, :text)
	end
end
