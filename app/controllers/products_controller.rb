class ProductsController < ApplicationController
  def index
    
    if params[:active] == 'true'
      @products = Product.active
    elsif params[:active] == 'false'
      @products = Product.inactive
    else
      @products = Product.active
    end
    
    
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

  def destroy
    @product = Product.find(params[:id])
    @product.deleted_at ||= Time.zone.now
    @product.save
    redirect_to products_path
  end
  
  def revive
    @product = Product.find(params[:id])
    @product.deleted_at = nil
    @product.save
    redirect_to products_path
  end
  
end