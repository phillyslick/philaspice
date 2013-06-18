class LineItemsController < ApplicationController
  layout 'front'
  # GET /cart_items
  # GET /cart_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /cart_items/new
  # GET /cart_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /cart_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    @cart = current_cart
    @line_item = @cart.add_product(params[:line_item][:price_id])
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to storefront_path, notice: "Added to Cart!"}
        format.js
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end
    
  
  # PUT /cart_items/1
  # PUT /cart_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:cart_item])
        format.html { redirect_to @line_item, notice: 'Cart item removed.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
    quantity = @line_item.quantity
    
    if quantity > 1
      quantity -= 1
      @line_item.update_attribute(:quantity, quantity)
    else
      @line_item.destroy
    end

    respond_to do |format|
      format.html { redirect_to store_index_path }
      format.json { head :no_content }
      format.js
    end
  end
end
