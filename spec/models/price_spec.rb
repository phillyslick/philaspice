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
  
end
