class CategoriesController < ApplicationController
  before_filter :setup_nav, :admin_required
  before_filter :find_category, :only => [:edit, :update, :destroy, :up, :down]

  def index
  end
  
  def new
    @category = Category.new
  end
  
  def edit
  end
  
  def create
    @category = Category.new(category_params)
    @category.profile_id = @current_profile.id
    
    if @category.save
      flash[:notice] = 'Category created.'
      redirect_to categories_path
    else
      render :action => 'new'
    end
  end
  
  def update
    if @category.update_attributes(category_params)
      flash[:notice] = 'Category saved.'
      redirect_to categories_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @category.items.empty?
      @category.destroy
      flash[:notice] = 'Category deleted.'
    else
      flash[:notice] = 'Category cannot be deleted while it contains items. Please delete the items first.'
    end
    redirect_to categories_url
  end

  def up
    @category.move_higher
    redirect_to categories_url
  end
  
  def down
    @category.move_lower
    redirect_to categories_url
  end

  private

    def find_category
      @category = Category.find(params[:id])
    end

    def setup_nav
      @nav = 'categories'
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
