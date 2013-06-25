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
    if params[:name].blank? || params[:email].blank?
      redirect_to front_contact_path
    else
      @mail_info = {
        name: params[:name],
        email: params[:email],
        phone: params[:phone],
        message: params[:message]
      }
      ContactMailer.contact(@mail_info).deliver
    redirect_to front_contact_path, notice: "Thanks!  We'll be in touch shortly."
    end
  end
  
  def thanks
  end
  
end
