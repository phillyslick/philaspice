class Price < ActiveRecord::Base
  belongs_to :variant
  belongs_to :weight
  attr_accessible :amount, :weight_id, :weight_attributes, :weight
  
  validates_presence_of :amount, :weight_id
  accepts_nested_attributes_for :weight
  
  def self.by_weight
    prices = Price.all.sort {|a,b| a.weight.raw <=> b.weight.raw}
    prices.reverse
  end
end
