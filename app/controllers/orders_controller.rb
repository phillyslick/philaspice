class OrdersController < ApplicationController
  layout 'front'
  def new
    @cart = current_cart
    @order = Order.new
    @order.addresses.build(kind: 'Shipping')
    @order.addresses.build(kind: 'Billing')
    @order.build_customer
  end
  
end
