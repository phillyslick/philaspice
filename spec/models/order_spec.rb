require 'spec_helper'
require 'active_shipping'
include ActiveMerchant::Shipping
describe Order do
  context "packages and shipping" do
    
    before do
      @packages = Order.create_packages(23232)
      @base_packages = 23232 / (16 * 50)
      @left_over = 23232 % 800
      if @left_over > 0
        @base_packages = @base_packages + 1
      end
    end
    
    it "can create the correct amount of packages" do
      expect(@packages.count).to be(@base_packages)
    end
    
    it "can create one package that is less than 50 lbs" do
      packages = Order.create_packages(322)
      expect(packages.count).to be(1)
    end
    
    it "creates the last package with the appropriate amount of ounces" do
      expect(@packages.last.oz).to be(@left_over.to_f)
    end
    
  end
  
end
