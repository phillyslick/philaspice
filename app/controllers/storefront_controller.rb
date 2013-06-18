class StorefrontController < ApplicationController
  layout 'front'
  def index
    @cart = current_cart
    @line_item = current_cart.line_items.build
    @products = Product.active.is_stocked
    @featured = Product.featured
    params[:category_id] ? @category = Category.find(params[:category_id]) : @category = Category.first
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
