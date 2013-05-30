class Product < ActiveRecord::Base
  attr_accessible :active, :deleted_at, :description, :featured, :name, :slug
  
  validates_presence_of :name
end
