# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_timezone, :initialize_user, :initialize_profile

  # make these available as ActionView helper methods.
  helper_method :logged_in?, :admin?

  # Check if the user is already logged in
  def logged_in?
    @current_user.is_a?(User)
  end
  
  def admin?
    logged_in? and @current_user.admin
  end

  def user_required
    unless logged_in?
      redirect_to :controller=>"sessions", :action=>"new"
    end
  end

  def admin_required
    unless admin?
      flash[:notice] = 'You must be logged in as an administrator.'
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end
  
  # setup user info on each page
  def initialize_user
    @current_user = User.find_by_id(session[:user])
  end

  # setup profile info on each page; dependent on host name in request
  def initialize_profile
    @current_profile = Profile.find_by_domain(request.host)
    if @current_profile.nil?
      render "public/404.html", :layout => false, :status => 404
    end
  end

  def set_timezone
    Time.zone = 'London'
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
