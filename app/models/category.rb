class Category < ActiveRecord::Base
  attr_accessible :active, :name, :slug
  
  validates_presence_of :name 
  has_many :products
  has_many :subcategories
  extend FriendlyId
  friendly_id :name, use: :slugged
end
