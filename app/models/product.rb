class Product < ActiveRecord::Base
  attr_accessible :active, :deleted_at, :description, :featured,
   :name, :slug, :temp_price, :variants_attributes, :category_id
  attr_accessor :temp_price
  
  has_many :variants
  has_many :active_variants, 
             class_name: "Variant", 
             conditions: ["variants.deleted_at IS NULL"]
  belongs_to :category

  accepts_nested_attributes_for :variants, :category
  
  validates_presence_of :name
  #validates_presence_of :temp_price, if: "new_record?"
  
  #after_create :check_for_variants
  
 #def check_for_variants
 #  variants.create(name: name, price: temp_price)
 #  save
 #end
  
  def hero_variant 
    variants.detect{ |v| v.master } || variants.first
  end
  
  def all_variant_prices
    all = []
    variants.each do |v|
      v.prices.each do |p|
        all << p.amount
      end
    end
    all
  end
  
  def display_price_range(j = ' to ')
    price_range.join(j)
  end
  
  def price_range
    return @price_range if @price_range
    return @price_range = ['N/A', 'N/A'] if active_variants.empty?
    @price_range = []
    @price_range << all_variant_prices.min
    @price_range << all_variant_prices.max
  end
  
  def price_range?
     !(price_range.first == price_range.last)
  end
  
  def price
    hero_variant.price
  end
  
  def lowest_price
    all_variant_prices.min
  end
  
  def active?(at = Time.zone.now)
    deleted_at.nil? || deleted_at >= at
  end

  def activate!
    self.deleted_at = nil
    save
  end

  def self.featured
    product = where({ :products => {:featured => true} } ).first
    product ? product : where(['products.deleted_at IS NULL']).first
  end
  
  def self.active
    where("products.deleted_at IS NULL OR products.deleted_at > ?", Time.zone.now)
  end
  
  def self.inactive
    where("products.deleted_at IS NOT NULL OR products.deleted_at > ?", Time.zone.now)
  end
  
  


end
