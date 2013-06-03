class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :products
  attr_accessible :name
end
