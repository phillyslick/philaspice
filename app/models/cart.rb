class Cart < ActiveRecord::Base
  has_many :line_items
  attr_accessible :line_item_attributes
  
  def add_product(price_id)
    price = Price.find(price_id)
    current_item = line_items.where(price_id: price_id,
                                    cost: price.amount,
                                    name: price.variant.name,
                                    ounces: price.weight.ounces,
                                    measurement: price.weight.unit).first
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(price_id: price_id,
                                    name: price.variant.name,
                                    ounces: price.weight.ounces,
                                    measurement: price.weight.unit)
                                    current_item.cost = price.amount
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end
  
  def total_weight_in_ounces
    if self.line_items.blank? 
      0
    else 
     line_items.to_a.sum do |item| 
        item.total_weight_in_ounces
      end
    end
  end
  
  def number_of_items
    number = 0
    line_items.each do |item|
      number += item.quantity
    end
    number
  end
  
end
