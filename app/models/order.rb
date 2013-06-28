class Order < ActiveRecord::Base
  require 'active_shipping'
  include ActiveMerchant::Shipping
  
  belongs_to :customer
  has_many :addresses
  has_many :line_items
  attr_accessible :archived_at, :shipping_cost, :total_price, :total_weight, :addresses_attributes,
  :line_item_attributes, :customer_id, :customer, :customer_attributes, :uuid, :shipping_method
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
  
  def calculate_weight
    if self.line_items.blank? 
      self.total_weight = 0
    else 
      self.total_weight = line_items.to_a.sum do |item| 
        item.total_weight_in_ounces
      end
    end
  end
  
  def grand_total
    self.total_price + self.shipping_cost
  end
  
  def self.create_packages(total_weight_in_ounces)
    packages = []
    number_of_full_packages = (total_weight_in_ounces / 800)
    ounces_left = total_weight_in_ounces % 800.0
    number_of_full_packages.times do
      packages << Package.new(800, [8, 8, 8], units: :imperial)
    end
    if ounces_left > 0
      packages << Package.new(ounces_left, [8, 8, 8], units: :imperial)
    end
    packages
  end
  
  def self.paid
    where("state = 'Paid' ")
  end
  
  def self.shipped
    where("state = 'Shipped'")
  end
  
  def self.total
    orders_paid = paid.sum do |order|
      if order.shipping_cost
        order.grand_total
      else
        order.total_price
      end
    end
    orders_shipped = shipped.sum do |order|
      if order.shipping_cost
        order.grand_total
      else
        order.total_price
      end
    end
    orders_paid + orders_shipped
  end
  

end
