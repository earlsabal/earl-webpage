class AdminSessionsController < ApplicationController  
  def show
  	redirect_to posts_path
  end

  def new
    @admin_session = AdminSession.new
  end
 
  def create
    @admin_session = AdminSession.new(params[:admin_session])
    if @admin_session.save
      flash[:notice] = "Login successful!"
      redirect_to posts_path
    else
      render :action => :new
    end
  end
 
  def destroy
  	current_admin_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to "/home"
  end
end