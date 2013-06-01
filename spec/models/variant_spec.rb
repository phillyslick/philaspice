require 'spec_helper'

describe Variant do
  before do
    @variant = create(:variant)
  end
  
  it "has a valid factory" do
    expect(@variant).to be_valid
  end
  
  context "validations" do
    it "must have a price" do
      @variant.price = nil
      expect(@variant).to have(1).errors_on :price
      @variant.price = 9.99
      expect(@variant).to have(0).errors_on :price
    end
    
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
  end
  
end
