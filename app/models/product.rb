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
  
end
