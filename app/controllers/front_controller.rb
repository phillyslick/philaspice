class FrontController < ApplicationController
  def index
    @sliders = Slider.limit(4)
    @option = Option.find(1)
    @featured = @option.product
    @cart = current_cart
  end
  
  def contact
    @cart = current_cart
    
  end
  
  def about
    @about = Page.find('about')
    @cart = current_cart
  end
  
end
