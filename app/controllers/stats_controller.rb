class StatsController < ApplicationController
  layout 'category'
  
  def index
    @orders = Order.all
  end
 
 
end
