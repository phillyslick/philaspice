class Weight < ActiveRecord::Base
  attr_accessible :ounces, :prices_attributes, :in_pounds
  
  has_many :variants, through: :prices, uniq: true
  has_many :prices
  
  validates_presence_of :ounces
  accepts_nested_attributes_for :variants, :prices
  
  def pounds
    if in_pounds?
      ounces
    else
      (ounces / 16).to_f.round(4)
    end
  end
  
  
  def display
    self.in_pounds? ? "#{ounces} lbs." : "#{ounces} oz."
  end
  
  def unit
    self.in_pounds? ? "Pounds" : "Ounces"
  end
    
  def raw
    if unit == "Pounds"
      ounces*16
    else
      ounces
    end
  end
end
