class StatsController < ApplicationController
    before_filter :authenticate_admin!
  layout 'category'
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def update_order_state
    @order = Order.find(params[:order_id])
    @order.state = params[:state]
    @order.save
    redirect_to stat_path(@order)
  end
 
 
end
