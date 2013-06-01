class Weight < ActiveRecord::Base
  attr_accessible :ounces
  
  has_many :variants, through: :prices
  has_many :prices
  
  validates_presence_of :ounces
  accepts_nested_attributes_for :variants
  
  def pounds
    (ounces / 16).to_f.round(4)
  end

end
