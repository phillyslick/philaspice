require 'spec_helper'

describe Price do
  
  before do
    @price = create(:price)
  end
  
  it "has a valid factory" do
    expect(@price).to be_valid
  end
  
  it "is invalid without an amount" do
    @price.amount = nil
    expect(@price).to have(1).errors_on :amount
    @price.amount = 10.0
    expect(@price).to be_valid
  end
  
  context "class methods" do
    it "can return prices by weight" do
      Price.delete_all
      Weight.delete_all
      low_price = create(:price, weight: Weight.create(ounces: 1.0))
      create(:price, weight: Weight.create(ounces: 10.0))
      high_price = create(:price, weight: Weight.create(ounces: 100.0))
      expect(Price.by_weight.first).to eql high_price
      expect(Price.by_weight.last).to eql low_price
    end
  end
  
end
