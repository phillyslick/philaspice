class Category < ActiveRecord::Base
  attr_accessible :active, :name
  
  validates_presence_of :name 
  has_many :products
  has_many :subcategories
end
