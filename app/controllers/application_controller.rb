class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def find_products
    if params[:query]
      if params[:product] && params[:product][:category_id].present?  
        category = Category.find(params[:product][:category_id])
        params[:active] == 'false' ? building_products = category.products.where("name @@ :q", q: params[:query]).inactive : building_products = category.products.where("name @@ :q", q: params[:query]).active
        params[:stocked] == 'false' ? @products = building_products.where("name @@ :q", q: params[:query]).unstocked : @products = building_products.where("name @@ :q", q: params[:query]).is_stocked
      elsif params[:category_id].present?
        category = Category.find(params[:category_id])
        params[:active] == 'false' ? building_products = category.products.where("name @@ :q", q: params[:query]).inactive : building_products = category.products.where("name @@ :q", q: params[:query]).active
        params[:stocked] == 'false' ? @products = building_products.where("name @@ :q", q: params[:query]).unstocked : @products = building_products.where("name @@ :q", q: params[:query]).is_stocked
      else
        params[:active] == 'false' ? building_products = Product.where("name @@ :q", q: params[:query]).inactive : building_products = Product.where("name @@ :q", q: params[:query]).active
        params[:stocked] == 'false' ? @products = building_products.where("name @@ :q", q: params[:query]).unstocked : @products = building_products.where("name @@ :q", q: params[:query]).is_stocked
      end
    elsif params[:product] && params[:product][:category_id].present?  
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
  
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart    
  end
end
