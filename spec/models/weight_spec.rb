require 'spec_helper'

describe Weight do
  before do
    @weight = create(:weight)
  end
  
  it "has a valid factory" do
    expect(@weight).to be_valid
  end
  
  it "requires an ounces value to be valid" do
    @weight.ounces = nil
    expect(@weight).to have(1).errors_on(:ounces)
    @weight.ounces = 123.213
    expect(@weight).to be_valid
  end
  
  
  context "instance methods" do
    it "can display it's weight in lbs" do
      @weight.ounces = 1
      expect(@weight.pounds.to_f).to eq(0.0625)
      @weight.ounces = 16
      expect(@weight.pounds.to_f).to eq(1)
    end
    
    it "can tell you its unit" do
      @weight.in_pounds = true
      expect(@weight.unit).to eql "Pounds"
    end
    
    it "can display its weight in ounces no matter" do
      @weight.in_pounds = true
      @weight.ounces = 10.0
      expect(@weight.raw).to eql(160.0)
    end
  end
  
end
