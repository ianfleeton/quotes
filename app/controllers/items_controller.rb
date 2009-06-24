class ItemsController < ApplicationController
  before_filter :admin_required

  def index
    @items = Item.all :order => :position
  end
  
  def new
    @item = Item.new
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def create
    @item = Item.new(params[:item])
    
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
end