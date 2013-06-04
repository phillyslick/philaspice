class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def find_products
    if params[:product] && params[:product][:category_id].present?  
      category = Category.find(params[:product][:category_id])
      params[:active] == 'false' ? building_products = category.products.inactive : building_products = category.products.active
      params[:stocked] == 'false' ? @products = building_products.unstocked : @products = building_products.is_stocked
    elsif params[:category_id].present?
      category = Category.find(params[:category_id])
      params[:active] == 'false' ? building_products = category.products.inactive : building_products = category.products.active
      params[:stocked] == 'false' ? @products = building_products.unstocked : @products = building_products.is_stocked
    else
      params[:active] == 'false' ? building_products = Product.inactive : building_products = Product.active
      params[:stocked] == 'false' ? @products = building_products.unstocked : @products = building_products.is_stocked
    end
  end
end
