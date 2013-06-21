class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :addresses
  has_many :line_items
  attr_accessible :archived_at, :shipping_cost, :total_price, :total_weight, :addresses_attributes,
  :line_item_attributes, :customer_id, :customer, :customer_attributes, :uuid
  accepts_nested_attributes_for :customer, :addresses, :line_items
  
  extend FriendlyId
  friendly_id :uuid, use: :slugged
    
  before_save :set_uuid

  def add_cart_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
    generate_total
  end
  
  def generate_total
    self.line_items.blank? ? self.total_price = 0.00 : self.total_price = line_items.to_a.sum {|item| item.total_price}
    self.total_price
  end
  
  def set_uuid
    self.uuid = SecureRandom.uuid if self.uuid.nil?
  end

end
