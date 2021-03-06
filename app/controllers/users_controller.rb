class UsersController < ApplicationController
  before_action :find_user, :except => [:index, :new, :create, :forgot_password, :forgot_password_send]
  before_action :admin_required, :only => [:index, :destroy]

  def index
    @users = User.order("name").all
  end
  
  def show
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.admin = false
    
    if @user.save
      flash[:notice] = "Successfully added new user."
      redirect_to :action => "show", :id => @user.id
    else
      render :action => "new"
    end
  end
  
  def edit
  end
  
  def update
    @user.admin = params[:user][:admin] if admin?
    if @user.update_attributes(user_params)
      flash[:notice] = "User successfully updated."
      redirect_to :action => "show", :id => @user.id
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "User successfully destroyed."
    redirect_to :action => "index"
  end

  def forgot_password
  end
  
  def forgot_password_send
    @user = User.find_by_email(params[:email])
    if @user.nil?
      flash[:notice] = "There is no user registered with that email address"
      redirect_to :action => "forgot_password"
    else
      @user.forgot_password_token = User.generate_forgot_password_token
      @user.save
      url = "#{reset_password_url}?id=#{@user.id}&t=#{@user.forgot_password_token}"
      UserNotifier.token(@user, @current_profile.from, @current_profile.name, url).deliver
    end
  end

  def forgot_password_new
    forgot_password_params_ok?
  end
  
  def forgot_password_change
    if forgot_password_params_ok?
      @user.password = params[:password]
      @user.forgot_password_token = ''
      @user.save
      flash[:notice] = 'Your password has been changed'
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end
  
  private
  
  def forgot_password_params_ok?
    if @user.forgot_password_token.blank?
      flash[:notice] = "Please enter your email address below"
      redirect_to :action => "forgot_password"
      return false
    elsif params[:t].nil? or @user.forgot_password_token != params[:t]
      flash[:notice] = "The link you entered was invalid. This can happen if you have re-requested " +
        "a forgot password email or you have already reset and changed your password."
      redirect_to :action => "forgot_password"
      return false
    end
    true
  end
  
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
