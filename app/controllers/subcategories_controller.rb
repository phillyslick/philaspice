class SubcategoriesController < ApplicationController
  layout 'category'
  def index
    @subcategories = Subcategory.all
  end
  
  def new
    @subcategory = Subcategory.new
  end
  
  def create
    @category = Category.find(params[:category_id])
    @subcategory = @category.subcategories.build(params[:subcategory])
    if @subcategory.save
      redirect_to categories_path, notice: "Subcategory Added!"
    else
      flash[:error] = "Sorry, something went wrong"
      render :new
    end
  end
  
  def edit
    @subcategory = Subcategory.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:category_id])
    @subcategory = @category.subcategories.find(params[:id])
    if @subcategory.update_attributes(params[:subcategory])
      redirect_to categories_path, notice: "Subcategory Modified"
    else
      flash[:error] = "Sorry, A Problem Occurred"
      render :edit
    end
  end
  
  def destroy
    @category = Category.find(params[:category_id])
    @subcategory = @category.subcategories.find(params[:id])
    @subcategory.delete
    redirect_to categories_path
  end
end