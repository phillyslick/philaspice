class ProductsController < ApplicationController
  def index
    find_products
  end
  
  def show
    find_products
    @product = Product.find(params[:id])
  end
  
  def new
    find_products
    @product = Product.new
    @product.variants.build
  end
  
  def edit
    find_products 
    @product = Product.find(params[:id])
  end
  
  def create
    @product = Product.new(params[:product])
    @product.name = params[:product][:variants_attributes]["0"][:name]
    @product.description = params[:product][:variants_attributes]["0"][:description]
    if @product.save
       @product.variants.first.add_price(params[:price], params[:weight])
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