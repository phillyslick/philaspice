class Variant < ActiveRecord::Base
  belongs_to :product
  attr_accessible :deleted_at, :master, :name, :price, :sku
  
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
  
  def product_name
    name? ? name : product.name
  end
  
  def name_with_sku
    [product_name, sku].compact.join(': ')
  end
  
end
