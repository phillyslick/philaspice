class Cart < ActiveRecord::Base
  has_many :line_items
  attr_accessible :line_item_attributes
  
  def add_product(price_id)
    price = Price.find(price_id)
    current_item = line_items.where(price_id: price_id,
                                    cost: price.amount,
                                    name: price.variant.name,
                                    ounces: price.weight.ounces).first
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(price_id: price_id,
                                    cost: price.amount,
                                    name: price.variant.name,
                                    ounces: price.weight.ounces)
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end
  
  def number_of_items
    number = 0
    line_items.each do |item|
      number += item.quantity
    end
    number
  end
  
end
