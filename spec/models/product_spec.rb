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
    
    it "must have a base_price" do
      @product.base_price = nil
      expect(@product).to have(1).errors_on :base_price
      @product.base_price = 9.00
      expect(@product).to be_valid
    end
    
  end
  
  describe "variant interaction" do
    it "always has at least one variant" do
      expect(@product.variants.count).to_not be(0)
    end
    
    it "has a hero variant - the main variant" do
      non_hero = @product.variants.create(master: false, name: "product variant", price: "9.99")
      hero_variant = @product.variants.create(master: true, name: "product variant2", price: "19.99")
      expect(@product.hero_variant.id).to eq hero_variant.id
    end
    
    it "defaults the hero variant to the first variant if none are marked as master" do
      expect(@product.hero_variant.id).to eq(@product.variants.first.id)
    end
    
    it "has active variants that are not deleted" do
      expect(@product.active_variants.count).to be(1)
      @product.variants.create(name: "product", price: "2.00", deleted_at: Time.now)
      expect(@product.active_variants.count).to be(1)
      @product.variants.create(name: "product", price: "2.00", deleted_at: nil)
      expect(@product.active_variants.count).to be(2)
    end
    
  end
  
  describe "instance methods" do
    
  end
  
end
