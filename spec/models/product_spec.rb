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
    it "always has at least one variant" do
      expect(@product.variants.count).to_not be(0)
    end
  end
  
  describe "instance methods" do
    
  end
  
end
