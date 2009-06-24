class SessionsController < ApplicationController
  def new
  end

  def create
    @current_user = User.authenticate(params[:email], params[:password])
    if @current_user
      session[:user] = @current_user.id
      if session[:next_controller].nil? or session[:next_action].nil?
        redirect_to quotes_path
      else
        redirect_to :controller => session[:next_controller],
                    :action => session[:next_action]
        session[:next_controller] = nil
        session[:next_action] = nil
      end
    else
      flash.now[:notice] = "No user was found with this email/password"
      render :action => "new"
    end
  end

  def destroy
    reset_session
    
    flash[:notice] = "Logged out successfully"
    redirect_to :action => "new"
  end
end
