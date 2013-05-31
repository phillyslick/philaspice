class VariantsController < ApplicationController
  def show
       @product = Product.find(params[:product_id])
    @variant = Variant.find(params[:id])
  end

  def new
    @product = Product.find(params[:product_id])
    @variant = @product.variants.build
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
      flash[:notice] = "Variant Created"
      redirect_to product_variant_path(@product,@variant)
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
      flash[:notice] = "Variant Updated"
      redirect_to product_variant_path(@product,@variant)
    else
      flash[:error] = "Sorry, Variant Couldn't Be Updated"
      render action: :edit
    end
      
  end

  def destroy
    @variant = Variant.find(params[:id])
    @variant.deleted_at ||= Time.zone.now
    @variant.save
    redirect_to products_path
  end
  
  def revive
    @variant = Variant.find(params[:id])
    @variant.deleted_at = nil
    @variant.save
    redirect_to products_path
  end
  
end