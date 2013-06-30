class Product < ActiveRecord::Base
  attr_accessible :active, :deleted_at, :description, :featured,
   :name, :slug, :variants_attributes, :category_id, :stocked,
   :subcategory_id, :alternate_names
  
  has_many :variants
  has_many :active_variants, 
             class_name: "Variant", 
             conditions: ["variants.deleted_at IS NULL"]
             
  has_many :stocked_variants,
    class_name: "Variant",
    conditions: ["variants.stocked IS TRUE"]
    
  has_many :unstocked_variants,
      class_name: "Variant",
      conditions: ["variants.stocked IS FALSE"]
    
  belongs_to :category
  belongs_to :subcategory

  accepts_nested_attributes_for :variants, :category
  
  
  validates_presence_of :name
  validate :subcategory_must_correspond_to_category, :if => :subcategory_id
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  

  def hero_variant 
    active_variants.detect{ |v| v.master } || variants.first
  end
  
  def front_hero
    active_variants.detect{ |v| v.master and v.stocked } || variants.first
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
    hero_variant.lowest_price
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
  
  def unstock_variants
    self.stocked = false
    variants.each{ |v| v.stocked = false }
    save
  end

  def stock_variants
    self.stocked = true
    variants.each{ |v| v.stocked = true }
    save
  end
  
  def stocked?
    variants.each{ |v| return true if v.stocked? }
    false
  end
  

  
  def count_for_master
    if active_variants.size == 1
      active_variants.first.master = true
      active_variants.first.save
    end
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
  
  def self.is_stocked
     Product.all.select{ |p| p.stocked? == true }
  end
  
  def self.unstocked
    Product.all.select{ |p| p.stocked? == false }
  end

  def self.alphabetical
    Product.order("lower(name)")
  end
  
  def self.search(query)
    if query.present?
      where("name @@ :q", q: query)
    else
      scoped.all
    end
  end
  
  private 
  
  def subcategory_must_correspond_to_category
    unless category_id == subcategory.category_id
      errors.add :subcategory_id, 'Subcategory must be from the same category that the product belongs to!'
    end
  end
  
end
