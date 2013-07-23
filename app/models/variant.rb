class Variant < ActiveRecord::Base
  belongs_to :product
  has_many :prices
  has_many :weights, through: :prices, uniq: true
  
  
  accepts_nested_attributes_for :weights, :prices
  attr_accessor :delete, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :deleted_at, :master, :name, :price, :sku, :delete, 
                  :crop_x, :crop_y, :crop_w, :crop_h, :description, 
                  :prices_attributes, :weights_attributes, :image, :stocked, :slug
                  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  before_create :set_as_master, :if => Proc.new { |variant| variant.product.variants.size == 0 }
  validates_presence_of :name
  
  mount_uploader :image, ImageUploader
  after_update :crop_image
  
  scope :recent, order("updated_at DESC")
 
  def crop_image
    image.recreate_versions! if crop_x.present?
  end
  
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
    measurement.downcase == "pounds" ? in_pounds = true : in_pounds = false
    w = Weight.create(ounces: quantity, in_pounds: in_pounds)
    Rails.logger.info(w.errors.inspect) 
    p = Price.create(amount: price, weight: w)
    Rails.logger.info(p.errors.inspect) 
    prices << p
     Rails.logger.info(self) 
  end

  def update_price(price_id, new_price, new_quantity, measurement="ounces")
    measurement.downcase == "pounds" ? in_pounds = true : in_pounds = false
    the_price = Price.find(price_id)
    the_weight = the_price.weight
    the_weight.update_attributes(ounces: new_quantity, in_pounds: in_pounds)
    the_price.update_attributes(amount: new_price, weight: the_weight)
  end
  
  def all_prices
    a_prices = []
    prices.each do |price|
      a_prices << price.amount
    end
    a_prices
  end
  
  def lowest_price
    all_prices.min
  end
  
  def prices_with_weights
    prices_and_weights = []
    prices.each do |price|
      prices_and_weights << [price.amount, price.weight.ounces]
    end
    prices_and_weights
  end
  
  def display_price_range(j = ' to ')
    price_range.join(j)
  end
  
  
  def price_range
    return @price_range if @price_range
    return @price_range = ['N/A', 'N/A'] if prices.empty?
    @price_range = prices.minmax {|a,b| a.amount.to_i <=> b.amount.to_i }.map(&:amount)
  end
  
  def set_as_master
    self.product.variants.where('id != ?', self.id).update_all("master = 'false'")
    self.master = true
  end

  def self.active
    where("variants.deleted_at IS NULL OR variants.deleted_at > ?", Time.zone.now)
  end
  
  def self.inactive
    where("variants.deleted_at IS NOT NULL OR variants.deleted_at > ?", Time.zone.now)
  end
  
  def self.is_stocked
    where("variants.stocked IS TRUE")
  end
  
  def self.unstocked
    where("variants.stocked IS NOT TRUE")
  end
  
  
end
