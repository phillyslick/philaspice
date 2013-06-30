class OptionsController < ApplicationController
  before_filter :authenticate_admin!
  layout 'category'
  
  def show
    @option = Option.find(1)
  end
  
  def update
    @option = Option.find(1)
    @option.update_attributes(params[:option])
    if params[:option][:image].present?
      render :crop
    else
      redirect_to option_path, notice: "Options updated!"
    end
  end
  
end