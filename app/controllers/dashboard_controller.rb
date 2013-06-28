class DashboardController < ApplicationController
before_filter :authenticate_admin!
  layout 'category'
  
  def index
    @orders = Order.completed.recent
  end
  
end
