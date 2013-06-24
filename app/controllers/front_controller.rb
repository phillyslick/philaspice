class FrontController < ApplicationController
  def index
    @sliders = Slider.limit(4)
    @option = Option.find(1)
    @featured = @option.product
    @cart = current_cart
  end
  
  def contact
    @cart = current_cart
    @contact = Page.find('contact')
  end
  
  def about
    @about = Page.find('about')
    @cart = current_cart
  end
  
  def contact_us
    @mail_info = {
      name: params[:name],
      email: params[:email],
      phone: params[:phone],
      message: params[:message]
    }
    render json: @mail_info
  end
  
end
