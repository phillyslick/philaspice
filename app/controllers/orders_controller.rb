class OrdersController < ApplicationController
  layout 'front'
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to storefront_path, notice: "Your Cart is Empty"
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
    @order.add_cart_items(@cart)
    if @order.valid?
      # Amount in cents
       @amount = (@order.total_price * 100).to_i
      begin
       charge = Stripe::Charge.create(
         :card    => params[:stripeToken],
         :amount      => @amount,
         :description => @order.customer.first_name,
         :currency    => 'usd'
       )

     rescue Stripe::CardError => e
       flash[:error] = e.message
       redirect_to new_order_path
     end
      @order.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
end
