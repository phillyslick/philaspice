class WeightsController < ApplicationController
  def index
    @weights = Weight.all
  end
  
  def new
    @weight = Weight.new
  end
  
  def create
    @weight = Weight.new(params[:weight])
    if params[:measurement] == "Ounces"
      @weight.ounces = params[:value]
    else
      @weight.ounces = params[:value].to_f * 16
    end
    if @weight.save
      redirect_to weights_path, notice: "Weight Added!"
    else
      flash[:error] = "Sorry, something went wrong"
      render :new
    end
  end
  
  def edit
    @weight = Weight.find(params[:id])
  end
  
  def update
    @weight = Weight.find(params[:id])
    if @weight.save
      redirect_to weights_path, notice: "Weight Modified"
    else
      flash[:error] = "Sorry, A Problem Occurred"
      render :edit
    end
  end
end