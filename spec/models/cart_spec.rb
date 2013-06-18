require 'spec_helper'

describe Cart do
  before do
    @cart = create(:cart)
  end
  
  it "has a valid factory" do
    expect(@cart).to be_valid
  end
end
