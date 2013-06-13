require 'spec_helper'

describe Variant do
  before do
    @variant = create(:variant)
  end
  
  it "has a valid factory" do
    expect(@variant).to be_valid
  end
  
  context "validations" do
    it "must have a name" do
      @variant.name = nil
      expect(@variant).to have(1).errors_on :name
      @variant.name = "A Product yo"
      expect(@variant).to have(0).errors_on :name
    end
  end
  
  context "instance methods" do
    it "has an active? method - tells if it is deleted" do
      expect(@variant.active?).to be_true
      @variant.deleted_at = Time.zone.now
      @variant.save
      expect(@variant.active?).to be_false
    end
    
    it "has an activate! method to undeleted" do
      expect(@variant.active?).to be_true
      @variant.deleted_at = Time.zone.now
      @variant.save
      expect(@variant.active?).to be_false
      @variant.activate!
      expect(@variant.active?).to be_true
    end
    
    it "has an inactivate! method to delete" do
      expect(@variant.active?).to be_true
      @variant.inactivate!
      expect(@variant.active?).to be_false
    end
    
    it "can return a 'active' or 'not active' accordingly" do
      expect(@variant.status).to eql "Active"
      @variant.inactivate!
      expect(@variant.status).to eql "Not Active"
    end
    
    it "can return its name with sku" do
      @variant.name = "Meees"
      @variant.sku = '124-12341-2431'
      @variant.save
      expect(@variant.name_with_sku).to eq "Meees: 124-12341-2431"
      @variant.sku = nil
      @variant.save
      expect(@variant.name_with_sku).to eq "Meees"
    end
    

  end
  
  context "Prices" do
    it "has an add_price method that adds a price on a weight" do
      @variant.add_price(9.99, 12)
      weight = @variant.weights.first
      expect(weight.ounces).to eq(12.0)
    end
    
    it "can update a price using a similar method" do
      @variant.add_price(9.99, 12)
      weight = @variant.weights.first
      expect(weight.ounces).to eq(12.0)
      @variant.update_price(@variant.prices.first.id, 11.0, 10)
      expect(@variant.prices.first.amount).to eql 11.0
      expect(@variant.weights.first.ounces).to eql 10.0
    end
    
    it "can provide pounds if it wants to enter the price in pounds" do
      @variant.add_price(9.99, 5.0, "Pounds")
      weight = @variant.weights.first
      expect(weight.raw).to eq(80.0)
      expect(weight.in_pounds).to be_true
    end
    
    it "can return an array of all prices" do
      @variant.add_price(8.98, 16)
      @variant.add_price(8.99, 32)
      @variant.add_price(20.00, 48)
      expect(@variant.all_prices).to eql([8.98,8.99,20.00])
    end
    
    it "can return an array of all weights and prices" do
      @variant.add_price(8.98, 16)
      @variant.add_price(8.99, 32)
      @variant.add_price(20.00, 48)
      expect(@variant.prices_with_weights).to eql([[8.98, 16],[8.99, 32], [20.00, 48]])
    end
    
    it "can return a range of lowest to highest price" do
      @variant.add_price(8.99, 16)
      @variant.add_price(15.00, 32)
      @variant.add_price(20.00, 48)
      expect(@variant.price_range).to eql([8.99,20.00])
    end
    
    it "can return a displayedrange of lowest to highest price" do
      @variant.add_price(8.99, 16)
      @variant.add_price(15.00, 32)
      @variant.add_price(20.00, 48)
      expect(@variant.display_price_range).to eql("8.99 to 20.0")
    end
    
    pending "can set itself as master and set all other sibling variants to master=false" do
      parent_product = create(:product)
      og_master = create(:variant, master: true, product: parent_product)
      @variant.product = parent_product
      @variant.save
      @variant.master = false
      expect(@variant.master).to be_false
      @variant.master = true
      @variant.save
      expect(@variant.master).to be_true
      expect(og_master.master).to be_false
    end
    
  end
  
  context "class methods" do
   #it "can return the first featured variant or first product if none featured" do
   #  @product.featured = false
   #  @product.save
   #  product_featured = create(:product, name: "the best", featured: true)
   #  expect(Product.featured).to eql product_featured
   #end
    
    it "can return variants that are active read: Not deleted" do
      @variant.deleted_at = Time.now
      @variant.save
      active_variant = create(:variant, name: "the best")
      expect(Variant.active).to include active_variant
      expect(Variant.active).to_not include @variant
    end
    
    it "can return variants that are inactive" do
      @variant.deleted_at = nil
      @variant.save
      expect(Variant.inactive).to_not include @variant
      @variant.deleted_at = Time.zone.now
      @variant.save
      expect(Variant.inactive).to include @variant
    end
    
    it "can return variants that are stocked" do
      variants = create_list(:variant, 4, stocked: true)
      no_variants = create_list(:variant, 4, stocked: false)
      expect(Variant.is_stocked).to match_array variants
      expect(Variant.is_stocked).to_not match_array no_variants
    end
    
    it "can return variants that are not stocked" do
      Variant.delete_all
      variants = create_list(:variant, 4, stocked: true)
      no_variants = create_list(:variant, 4, stocked: false)
      expect(Variant.unstocked).to match_array no_variants
      expect(Variant.unstocked).to_not match_array variants
    end
  end
  
end
