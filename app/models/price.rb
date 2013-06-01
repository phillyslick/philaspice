class Price < ActiveRecord::Base
  belongs_to :variant
  belongs_to :weight
  attr_accessible :amount, :weight_id, :weight_attributes, :weight
  
  validates_presence_of :amount, :weight_id
end
