class ProductsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!
  def index
    find_products
    params[:id] ? @product = Product.find(params[:id]) : @product = Product.active.first
    @product = Product.first unless @product
  end
  
  def show

    params[:id] ? @product = Product.find(params[:id]) : @product = Product.active.first
  end
  
  def new
    find_products
    @product = Product.new
    @variant = @product.variants.build
    @default_weights = Weight::DEFAULT_WEIGHTS
    @default_weights.each do |d|
      @variant.weights.build(
      ounces: d[:weight],
      in_pounds: d[:pounds]
      )
    end

    if params[:category]
      @category = Category.find(params[:category])
    else
      @category = Category.first
    end
  end
  
  def edit
    find_products 
    @product = Product.find(params[:id])
    if params[:category]
      @category = Category.find(params[:category])
    else
      @category = @product.category
    end
    render layout: "modal"
  end
  
  def create
    @default_weights = Weight::DEFAULT_WEIGHTS
    @product = Product.new(params[:product])
    @product.name = params[:product][:variants_attributes]["0"][:name]
    @product.description = params[:product][:variants_attributes]["0"][:description]
    if @product.save
      @variant = @product.variants.first
      params[:pricesa].each_pair do |k,v|
         Rails.logger.info(v.to_i) 
        @variant.add_price(v.to_i,
         @default_weights[k.to_i][:weight],
          @default_weights[k.to_i][:unit])
           @variant.save
      end
     
      if params[:product][:variants_attributes]["0"][:image].present?
        render :crop
      else
        redirect_to @product, notice: "Product Created"
      end
      
    else
      flash[:error] = "Sorry, Product Could Not Be Saved"
      render action: :new
    end
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      if params[:product][:varaints_attributes].present?
        if params[:product][:variants_attributes]["0"][:image].present?
          render :crop
        else
          redirect_to @product, notice: "Product Updated"
        end
      else
        redirect_to @product, notice: "Product Updated"
      end
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
    redirect_to @product
  end
  
  def unstock
    @product = Product.find(params[:id])
    @product.unstock_variants
    redirect_to @product
  end
  
  def stock
    @product = Product.find(params[:id])
    @product.stock_variants
    redirect_to @product
  end
  
  
end