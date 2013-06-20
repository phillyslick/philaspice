class StorefrontController < ApplicationController
  layout 'front'
  def index
    @cart = current_cart
    @line_item = current_cart.line_items.build
    if params[:query]
      @products = Product.search(params[:query])
    end
    @featured = Product.featured
    if params[:category_id]
      @category = Category.find(params[:category_id])
    else
      @category = Category.first
    end
  end
  
  def product
    @cart = current_cart
    @line_item = current_cart.line_items.build
    @product = Product.active.find(params[:id])
    if params[:variant_id]
      @selected_variant = @product.variants.find(params[:variant_id])
    else
      @selected_variant= @product.front_hero
    end
  end

  def review_order
    @cart = current_cart
  end
  
  def checkout
  end
  
  def thank_you
  end
  
end
