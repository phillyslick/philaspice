class DashboardController < ApplicationController
before_filter :authenticate_admin!
  layout 'category'
  
  def index
    @orders = Order.completed.recent
    @unshipped_orders = Order.paid.order("updated_at DESC")
  end
  
  def help
  
  end
  
  
end
