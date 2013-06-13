require 'spec_helper'

describe Product do
  before do
    @product = create(:product)
  end
  
  it "has a valid factory" do
    expect(@product).to be_valid
  end
  
  describe "validations" do
    it "must have a name" do
      @product.name = nil
      expect(@product).to have(1).errors_on :name
      @product.name = "Ground Pepper"
      expect(@product).to be_valid
    end
  end
  
  describe "callbacks" do
    it "checks to make sure the subcategory assigned belongs to the category assigned" do
      cat = @product.category
      subcat = cat.subcategories.create(name: "Stuffs")
      @product.subcategory = subcat
      @product.save
      expect(@product).to be_valid
      stray_cat = create(:category)
      stray_sub = stray_cat.subcategories.create(name: "SubSuf")
      @product.subcategory = stray_sub
      @product.save
      expect(@product).to_not be_valid
      expect(@product).to have(1).errors_on :subcategory_id
      @product.category = cat
      @product.subcategory = subcat
      @product.save
      expect(@product).to be_valid
    end
  end
  
  describe "variant interaction" do
    
    it "has a hero variant - the main variant" do
      non_hero = @product.variants.create(master: false, name: "product variant", price: "9.99")
      hero_variant = @product.variants.create(master: true, name: "product variant2", price: "19.99")
      expect(@product.hero_variant.id).to eq hero_variant.id
    end
    
    it "defaults the hero variant to the first variant if none are marked as master" do
       non_hero = @product.variants.create(master: false, name: "product variant", price: "9.99")
      expect(@product.hero_variant.id).to eq(@product.variants.first.id)
    end
    
    it "has active variants that are not deleted" do
        non_hero = @product.variants.create(master: false, name: "product variant", price: "9.99")
      expect(@product.active_variants.count).to be(1)
      @product.variants.create(name: "product", price: 2.00, deleted_at: Time.now)
      expect(@product.active_variants.count).to be(1)
      @product.variants.create(name: "product", price: 2.00, deleted_at: nil)
      expect(@product.active_variants.count).to be(2)
    end
    
    it "has a front_hero that is an active, stocked, and master variant (falls back to first active)" do
      non_front = @product.variants.create(master: true, name: "product variant", price: "9.99", stocked: false)
      front = @product.variants.create(master: true, name: "product variantf", price: "19.99", stocked: true)
      expect(@product.front_hero).to eql(front)
    end
    
  end
  
  describe "category interaction" do
    it "can have a category" do
      expect(@product.category.class).to be Category
    end
  end
  
  describe "instance methods" do
    
    it "can return all of its variant prices in an array" do
      variants = create_list(:variant, 5)
      @product.variants = []
      @product.variants = variants
      @product.save
      prices = []
      @product.variants.collect do |v|
       prices = v.prices.each {|p| p.amount}
      end
      puts prices
      expect(@product.all_variant_prices).to eql(prices)
    end
    
    it "has a price_range that returns a range of variant prices" do
      non_hero = @product.variants.create(master: false, name: "product variant")
      non_hero.prices.create(amount: 100)
      non_hero.prices.create(amount: 10)
      non_hero.prices.create(amount: 1)
      variant = @product.variants.create(master: false, name: "product varian1t")
      variant.prices.create(amount: 1010)
      variant.prices.create(amount: 110)
      variant.prices.create(amount: 32)
      expect(@product.display_price_range).to eq "1.0 to 1010.0"
    end
    
    it "returns n/a if no active variants" do
      non_hero = @product.variants.create(master: false, name: "product variant")
      variant = @product.variants.first
      variant.deleted_at = Time.now
      variant.save
      expect(@product.display_price_range).to eq "N/A to N/A"
    end
    
    it "has a price that returns the hero_variant's lowest price" do
       variant2 = @product.variants.create(name: "Whats", master: true)
       variant2.prices << create(:price, variant: variant2, amount: 90.0)
       variant2.prices << create(:price, variant: variant2, amount: 190.0)
       expect(@product.price).to eq(90.0)
    end
    
    it "can return the lowest price" do
      non_hero = @product.variants.create(master: false, name: "product variant")
      non_hero.prices.create(amount: 100)
      non_hero.prices.create(amount: 10)
      non_hero.prices.create(amount: 1)
      variant = @product.variants.create(master: false, name: "product varian1t")
      variant.prices.create(amount: 1010)
      variant.prices.create(amount: 110)
      variant.prices.create(amount: 32)
      expect(@product.lowest_price).to eq(1.0)
    end
    
    it "can tell you if it is deleted or not: active" do
      expect(@product.active?).to be_true
      @product.deleted_at = Time.zone.now
      @product.save
      expect(@product.active?).to be_false
    end
    
    it "has an activate! method that undeletes a product" do
      expect(@product.active?).to be_true
      @product.deleted_at = Time.zone.now
      @product.save
      expect(@product.active?).to be_false
      @product.activate!
      expect(@product.active?).to be_true
    end 
    
    it "can stock all of its variants" do
      @product.variants = create_list(:variant, 5, stocked: false)
      @product.stock_variants
      @product.variants.each do |v|
        expect(v.stocked).to be_true
      end
    end
    
    it "can de/unstock all of its variants" do
      @product.variants = create_list(:variant, 5, stocked: true)
      @product.unstock_variants
      @product.variants.each do |v|
        expect(v.stocked).to be_false
      end
    end
    
    it "can tell if any of its variants have any stock" do
      @product.variants = create_list(:variant, 5, stocked: false)
      expect(@product.stocked?).to be_false
      @product.variants.first.stocked = true
      expect(@product.stocked?).to be_true
    end
    
    it "detects if there's only one active_variant left and sets it to master" do
      @product.variants << create(:variant, master: false, deleted_at: nil, product: @product)
      @product.save
      @product.count_for_master
      expect(@product.variants.first.master).to be_true
    end
    
  end
  
  describe "class methods" do
    it "can return the first featured product or first product if none featured" do
      @product.featured = false
      @product.save
      product_featured = create(:product, name: "the best", featured: true)
      expect(Product.featured).to eql product_featured
    end
    
    it "can return products that are active read: Not deleted" do
      @product.deleted_at = Time.now
      @product.save
      active_product = create(:product, name: "the best")
      expect(Product.active).to include active_product
      expect(Product.active).to_not include @product
    end
    
    it "can return products that are inactive" do
      @product.deleted_at = nil
      @product.save
      expect(Product.inactive).to_not include @product
      @product.deleted_at = Time.zone.now
      @product.save
      expect(Product.inactive).to include @product
      
    end
    
    it "can return products that are stocked and unstocked" do
      product2 = create(:product)
      product2.variants << create_list(:variant, 2, stocked: false, product: product2)
      @product.variants << create_list(:variant, 3, stocked: true, product: @product)
      @product.save
      product2.save
      expect(Product.is_stocked).to include @product
      expect(Product.unstocked).to include product2
    end
    
    it "can search for product by name" do
      @product.name = "Spicy Ketchup"
      @product.save
      product2 = create(:product, name: "Ketchup")
      expect(Product.search("Ketchup").count).to be(2)
    end
    
  end
  
end
