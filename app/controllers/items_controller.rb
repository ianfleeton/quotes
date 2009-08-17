class ItemsController < ApplicationController
  before_filter :setup_nav, :admin_required

  def index
  end
  
  def new
    @item = Item.new
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def create
    @item = Item.new(params[:item])

    # check that the submitted category exists
    # and belongs to the same website profile
    category = Item.find_by_id(params[:item][:category_id])
    if category.nil? or category.profile_id != @current_profile.id
      flash[:notice] = 'Invalid category.'
      render :action => 'new'
      return
    end
    @item.category_id = category.id
    
    @item.profile_id = @current_profile.id
    
    if @item.save
      flash[:notice] = 'Item created.'
      redirect_to items_path
    else
      render :action => 'new'
    end
  end
  
  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(params[:item])
      flash[:notice] = 'Item saved.'
      redirect_to items_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = 'Item deleted.'
    redirect_to items_url
  end

  def up
    @item = Item.find(params[:id])
    @item.move_higher
    redirect_to items_url
  end
  
  def down
    @item = Item.find(params[:id])
    @item.move_lower
    redirect_to items_url
  end

  private

  def setup_nav
    @nav = 'items'
  end
end