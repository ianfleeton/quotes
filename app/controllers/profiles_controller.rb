class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end
  
  def edit
    @profile = Profile.find(params[:id])
  end
  
  def create
    @profile = Profile.new(params[:profile])
    
    if @profile.save
      flash[:notice] = 'Profile created.'
      redirect_to profiles_path
    else
      render :action => 'new'
    end
  end
  
  def update
    @profile = Profile.find(params[:id])

    if @profile.update_attributes(params[:profile])
      flash[:notice] = 'Profile saved.'
      redirect_to profiles_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    flash[:notice] = 'Profile deleted.'
    redirect_to profiles_url
  end
end