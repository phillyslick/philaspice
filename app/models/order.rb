class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :addresses
  has_many :line_items
  attr_accessible :archived_at, :shipping_cost, :total_price, :total_weight, :address_attributes,
  :line_item_attributes, :customer_id, :customer
  accepts_nested_attributes_for :customer, :addresses, :line_items
end
