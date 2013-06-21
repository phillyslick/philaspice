class FrontController < ApplicationController
  def index
    @sliders = Slider.limit(4)
  end
  
  def contact
  end
  
  def about
    @about = Page.find('about')
  end
  
end
