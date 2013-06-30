class StatsController < ApplicationController
    before_filter :authenticate_admin!
  layout 'category'
  
  def index
    case params[:state]
    when "Paid"
      @orders = Order.order("created_at DESC").paid.page(params[:page]).per(10)
    when "Shipped"
      @orders = Order.order("created_at DESC").shipped.page(params[:page]).per(10)
    when "Unpaid"
      @orders = Order.order("created_at DESC").unpaid.page(params[:page]).per(10)
    else
      @orders = Order.order("created_at DESC").page(params[:page]).per(10)
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def update_order_state
    @order = Order.find(params[:order_id])
    @order.state = params[:state]
    @order.save
    redirect_to stats_path
  end
 
 
end
