class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :order
  belongs_to :price
  attr_accessor :variant_id
  attr_accessible :cart_attributes, :price_attributes, :price, :cart,
                  :price_id, :name, :ounces, :quantity, :variant_id, :measurement
  
  def total_price
    unless quantity.blank? || cost.blank?
      quantity * cost
    else
      0.00
    end
  end
  
  def total_weight_in_ounces
    unless ounces.blank?
      measurement =~ /Ounces/i ? ounces * quantity : ounces * 16 * quantity
    else
      0
    end
  end
  
  def formatted_price
    sprintf( "%0.02f", price)
  end
  
  def info
    "#{name} - #{ounces} #{measurement}"
  end
end
