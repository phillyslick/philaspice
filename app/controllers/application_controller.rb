class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def find_products
    if params[:product] && params[:product][:category_id].present?  
      category = Category.find(params[:product][:category_id])
      params[:active] == 'false' ? @products = category.products.inactive : @products = category.products.active
    else
      params[:active] == 'false' ? @products = Product.inactive : @products = Product.active
    end
  end
end
