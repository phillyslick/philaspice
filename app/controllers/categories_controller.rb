class CategoriesController < ApplicationController
  before_filter :authenticate_admin!
  
  layout 'category'
  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save 
      redirect_to categories_path, notice: "Category Added!"
    else
      flash[:error] = "Sorry, something went wrong"
      render :new
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to categories_path, notice: "Category Modified"
    else
      flash[:error] = "Sorry, A Problem Occurred"
      render :edit
    end
  end
  
  def destroy
   @category = Category.find(params[:id])
   @category.destroy
   redirect_to categories_path, notice: "Category Deleted"
  end
end