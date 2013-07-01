class OrdersController < ApplicationController
  layout 'front'
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_path, notice: "Your Cart is Empty"
      return
    end
    @order = Order.new
    @order.addresses.build(kind: 'Billing')
    @order.addresses.build(kind: 'Shipping')
    @order.build_customer
  end
  
  def create
    @cart = current_cart
    @order = Order.new(params[:order])
    @order.state = "Unpaid"
    if @order.save
      redirect_to storefront_review_order_path(@order.uuid)
    else
      render :new
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
end
