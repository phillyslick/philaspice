class Weight < ActiveRecord::Base
  attr_accessible :ounces, :prices_attributes, :in_pounds
  
  has_many :variants, through: :prices, uniq: true
  has_many :prices
  
  validates_presence_of :ounces
  accepts_nested_attributes_for :variants, :prices
  
  #in ounces
  DEFAULT_WEIGHTS = [
    { weight: 2, pounds: false, unit: 'Ounces' },
    { weight: 4, pounds: false, unit: 'Ounces' },
    { weight: 8, pounds: false, unit: 'Ounces' },
    { weight: 1, pounds: true, unit: "Pounds" },
    { weight: 5, pounds: true, unit: "Pounds" },
    { weight: 10, pounds: true, unit: "Pounds" },
    { weight: 25, pounds: true, unit: "Pounds" }
  ]
  
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
