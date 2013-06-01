class Weight < ActiveRecord::Base
  attr_accessible :ounces
  
  has_many :variants, through: :variant_weights
  has_many :variant_weights
  
  validates_presence_of :ounces
  accepts_nested_attributes_for :variants
  
  def pounds
    (ounces / 16).to_f.round(4)
  end

end
