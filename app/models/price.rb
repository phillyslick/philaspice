class Price < ActiveRecord::Base
  belongs_to :variant
  belongs_to :weight
  has_many :line_items
  attr_accessible :amount, :weight_id, :weight_attributes, :weight
  
  validates_presence_of :amount
  accepts_nested_attributes_for :weight
  
  def self.by_weight
    prices = Price.all.sort {|a,b| a.weight.raw <=> b.weight.raw}
    prices
  end
  
  def weight_and_price
    "#{weight.display} for $#{amount}"
  end
  
  def pretty
    "$#{amount}"
  end
  
  def self.active
    where("amount > 0")
  end

end
