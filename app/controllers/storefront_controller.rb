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
    @order = Order.find_by_uuid(params[:slug])
    if @order.state == "Paid"
      redirect_to root_path
    end
  end
  
  def pay
    @cart = current_cart
    @order = Order.find(params[:order_id])
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
      @order.state = "Paid"
      @order.save
      PaymentMailer.customer_confirm(@order).deliver
      PaymentMailer.accepted_alert(@order).deliver
      redirect_to front_thanks_path
    else
      render :review_order
    end
  end
  
  def checkout
  end
  
  def thank_you
  end
  
end
