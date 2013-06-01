class Variant < ActiveRecord::Base
  belongs_to :product
  has_many :prices
  has_many :weights, through: :prices, uniq: true
  
  accepts_nested_attributes_for :weights, :prices
  attr_accessor :delete
  attr_accessible :deleted_at, :master, :name, :price, :sku, :delete

  validates_presence_of :price, :name 
  
  def active?
    deleted_at.nil? || deleted_at > Time.zone.now
  end
  
  def activate!
    self.deleted_at = nil
    save
  end
  
  def inactivate!
    self.deleted_at = Time.zone.now
    save
  end
  
  def status
    active? ? "Active" : "Not Active"
  end
  
  def product_name
    name? ? name : product.name
  end
  
  def name_with_sku
    [product_name, sku].compact.join(': ')
  end
  
  def add_price(price, quantity, measurement="ounces")
    quantity = quantity * 16.0 if measurement.downcase == "pounds"
    prices.create(amount: price, weight: Weight.create(ounces: quantity))
  end
  
  def all_prices
    prices_and_weights = []
    prices.each do |price|
      prices_and_weights << [price.amount, price.weight.ounces]
    end
    prices_and_weights
  end
  
  def self.active
    where("variants.deleted_at IS NULL OR variants.deleted_at > ?", Time.zone.now)
  end
  
  def self.inactive
    where("variants.deleted_at IS NOT NULL OR variants.deleted_at > ?", Time.zone.now)
  end
  
end
