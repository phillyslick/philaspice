class VariantsController < ApplicationController
  before_filter :authenticate_admin!
  
  layout 'admin'
  def show
    @product = Product.find(params[:product_id])
    @variant = Variant.find(params[:id])
  end

  def new
    @product = Product.find(params[:product_id])
    @variant = @product.variants.build
    respond_to do |format|
      format.html
      format.json
      format.js
    end
  end
  
  def edit
    @product = Product.find(params[:product_id])
    @variant = Variant.find(params[:id])
    @variant.active? ? @active = true : @active = false
    
  end
  
  def create
    @product = Product.find(params[:product_id])
    @variant = @product.variants.create(params[:variant])
    
    if @variant.save
      @variant.add_price(params[:price], params[:weight])
      
      if params[:variant][:image].present?
        render :crop
      else
        redirect_to @product, notice: "Variant Created"
      end
      
    else
      flash[:error] = "Sorry, Variant Could Not Be Saved"
      render action: :new
    end
  end
  
  def update
    @variant = Variant.find(params[:id])
    @product = Product.find(params[:product_id])
 
    if @variant.update_attributes(params[:variant])
      if params[:delete] == "false"
        @variant.inactivate!
      elsif params[:delete] == "trues"
        @variant.activate!
      end
      if params[:variant][:image].present?
        render :crop
      else
        redirect_to @product, notice: "Variant Created"
      end
    else
      flash[:error] = "Sorry, Variant Couldn't Be Updated"
      render action: :edit
    end
      
  end

  def destroy
    @variant = Variant.find(params[:id])
    @variant.deleted_at ||= Time.zone.now
    @variant.save
    @variant.product.count_for_master
    redirect_to @variant.product
  end
  
  def revive
    @variant = Variant.find(params[:id])
    @variant.deleted_at = nil
    @variant.save
    redirect_to @variant.product
  end
  
  def weights
    @variant = Variant.find(params[:id])
    @product = Product.find(params[:product_id])
  end
  
  def edit_weight
    @product = Product.find(params[:product_id])
    @weight = Weight.find(params[:weight_id])
    @variant = Variant.find(params[:id])
    @price = Price.find(params[:price_id])

  end
  
  def save_weight
    @variant = Variant.find(params[:id])
    @variant.add_price(params[:price], params[:weight], params[:measurement])
    redirect_to @variant.product
  end

  def update_weight
    @variant = Variant.find(params[:id])
    @variant.update_price(params[:price_id], params[:price], params[:weight], params[:measurement])
    @variant.save
    redirect_to @variant.product
  end
  
  def delete_price  
    price = Price.find(params[:price_id])
    @variant = Variant.find(params[:id])
    price.destroy
    redirect_to @variant.product
  end
  
  def master
    @variant = Variant.find(params[:id])
    @variant.set_as_master
    @variant.save
    redirect_to @variant.product
  end
  
  def unstock
    @variant = Variant.find(params[:id])
    @variant.stocked = false
    @variant.save
    redirect_to @variant.product
  end
  
  def stock
    @variant = Variant.find(params[:id])
    @variant.stocked = true
    @variant.save
    redirect_to @variant.product
  end
  
end