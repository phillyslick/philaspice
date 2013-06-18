class FrontController < ApplicationController
  def index
  end
  
  def contact
  end
  
  def about
    @about = Page.find('about')
  end
  
end
