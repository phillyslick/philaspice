require 'spec_helper'

describe Category do
  before do
    @category = create(:category)
  end
  
  it "has a valid factory" do
    expect(@category).to be_valid
  end
  
  it "requires a name to be valid" do
    @category.name = nil
    expect(@category).to have(1).errors_on :name
    @category.name = "Nuts"
    expect(@category).to be_valid
  end
  
  it "can have many products" do
    expect(@category.products.count).to be(0)
    product = create(:product, category: @category)
    product2 = create(:product, category: @category)
    @category.save
    expect(@category.products.count).to be(2)
  end
end
