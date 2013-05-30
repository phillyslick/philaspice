class Product < ActiveRecord::Base
  attr_accessible :active, :deleted_at, :description, :featured, :name, :slug, :base_price
  
  has_many :variants
  has_many :active_variants, 
             class_name: "Variant", 
             conditions: ["variants.deleted_at IS NULL"]

  accepts_nested_attributes_for :variants
  
  validates_presence_of :name, :base_price
  
  after_create :check_for_variants
  
  def check_for_variants
    variants.create(name: name, price: base_price) if variants.count < 1
    save
  end
  
  def hero_variant 
    variants.detect{ |v| v.master } || variants.first
  end
  
  def display_price_range(j = ' to ')
    price_range.join(j)
  end
  
  def price_range
    return @price_range if @price_range
    return @price_range = ['N/A', 'N/A'] if active_variants.empty?
    @price_range = active_variants.minmax {|a,b| a.price <=> b.price }.map(&:price)
  end
  
  def price_range?
     !(price_range.first == price_range.last)
  end
  
  def price
    hero_variant.price
  end


end
