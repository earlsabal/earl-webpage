class PagesController < ApplicationController
	def Home
	end

	def about
		@message = Message.new
	end
end
