class Category < ActiveRecord::Base
  attr_accessible :active, :name, :slug
  
  validates_presence_of :name 
  has_many :products
  has_many :subcategories, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def featured
    product = Product.is_stocked.active.where(:category_id => self.id).first
    product ? product : Product.where(['products.deleted_at IS NULL']).first
  end
  
  def active?
    if self.subcategories.size > 0 && products.active.is_stocked.size > 0
      true
    else
      false
    end
  end
  
  def self.active
    Category.all.select{ |p| p.active? == true }  
  end
end
