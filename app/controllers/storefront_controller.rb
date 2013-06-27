class StorefrontController < ApplicationController
  require 'active_shipping'
  include ActiveMerchant::Shipping
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
    @rates = generate_rates(@cart, @order)
    
    if params[:selected_rate]
      [:selected_rate] > 6.00 ? @selected_rate = [:selected_rate] : @selected_rate = @rates[:usps]
    else
      @selected_rate = @rates[:usps]
    end
    
    if @order.state == "Paid"
      redirect_to root_path
    end
  end
  
  def pay
    @cart = current_cart
    @order = Order.find(params[:order_id])
    
    if params[:selected_rate]
      @order.shipping_cost = determine_shipping(@cart, @order, params[:selected_rate])
      @order.shipping_method = params[:selected_rate]
    else
      redirect_to storefront_review_order_path(@order.uuid), notice: "Select a Shipping Method!"
      return
    end
    
    @order.add_cart_items(@cart)
    
    
    if @order.valid?
      # Amount in cents
       @amount = (@order.grand_total * 100).to_i
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
  
  
  def create_packages(total_weight_in_ounces)
    packages = []
    package = Package.new(total_weight_in_ounces, [8, 8, 8], units: :imperial)
    packages << package
    packages
  end
  
  def create_origin
    origin = Location.new(country: "US",
                          state: "PA",
                          city: "Philadelphia",
                          zip: '19128')
    origin
  end
  
  def create_destination(customer)
    destination = Location.new(country: "US",
                              state: customer.state,
                              city: customer.city,
                              zip: customer.zip)
    destination
  end
  
  def ups_rates(origin, destination, packages)
    ups = UPS.new(login: 'phillyslick',
                  password: 'Sh3rl0ck215',
                  key: 'DCB92DB31B6D5D46')
                  
    response = ups.find_rates(origin, destination, packages)
    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    ups_rates
  end
  
  def usps_rate(weight_in_ounces)
    rates = {small: 6.00, medium: 12.35, large: 16.85}
    if weight_in_ounces < 16
      rate = rates[:small]
    elsif weight_in_ounces < 25
      rate = rates[:medium]
    else
      rate = rates[:large]
    end
    rate
  end
  
  def determine_shipping(cart, order, selected_ship)
    unless selected_ship =~ /pickup/
      rates = generate_rates(cart, order)
      rates[selected_ship.to_sym]
    else
      0
    end
  end
  
  def generate_rates(cart, order)
    packages = create_packages(cart.total_weight_in_ounces)
    origin = create_origin
    destination = create_destination(order.addresses.where(kind: "Shipping").first)
    ups_rates = ups_rates(origin, destination, packages)
    usps_rate = usps_rate(cart.total_weight_in_ounces)
    rates = {
      ups: ups_rates.last.last/100.to_f,
      usps: usps_rate
    }
    rates
  end
  
  
end
