class SlidersController < ApplicationController
  before_filter :authenticate_admin!
  
  layout 'category'
  def index
    @sliders = Slider.all
  end
  
  def new
    @slider = Slider.new
  end
  
  def create
    @slider = Slider.new(params[:slider])
    if @slider.save 
      if params[:slider][:picture].present?
        render :crop
      else
        redirect_to sliders_path, notice: "Slider Added!"
      end
    else
      flash[:error] = "Sorry, something went wrong"
      render :new
    end
  end
  
  def edit
    @slider = Slider.find(params[:id])
  end
  
  def update
    @slider = Slider.find(params[:id])
    if @slider.update_attributes(params[:slider])
      if params[:slider][:picture].present?
        render :crop
      else
        redirect_to sliders_path, notice: "Slider Modified"
      end
    else
      flash[:error] = "Sorry, A Problem Occurred"
      render :edit
    end
  end
  
  def destroy
    @slider = Slider.find(params[:id])
    @slider.destroy
    redirect_to sliders_path, notice: "Slider Destroyed"
  end
end