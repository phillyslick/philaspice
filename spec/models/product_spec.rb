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
    
  end
  
  describe "category interaction" do
    it "can have a category" do
      expect(@product.category.class).to be Category
    end
  end
  
  describe "instance methods" do
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
    
    it "has a price that returns the hero_variant's price" do
       variant2 = @product.variants.create(name: "Whats", price: 90.00, master: true)
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
    
  end
  
end
