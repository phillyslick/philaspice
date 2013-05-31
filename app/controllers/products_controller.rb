class ProductsController < ApplicationController
  def index
    @products = Product.all
    @variants = Variant.all
    #show variants for each
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def create
  end
  
  def new
    @product = Product.new
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Product Created"
      redirect_to @product
    else
      flash[:errro] = "Sorry, Product Could Not Be Saved"
      render action: :new
    end
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product Updated"
      redirect_to @product
    else
      flash[:error] = "Sorry, Product Couldn't Be Updated"
      render action: :edit
    end
      
  end

end