class Category < ActiveRecord::Base
  attr_accessible :active, :name, :slug
  
  validates_presence_of :name 
  has_many :products
  has_many :subcategories
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def featured
    product = Product.is_stocked.active.where(:category_id => self.id).first
    product ? product : Product.where(['products.deleted_at IS NULL']).first
  end
end
