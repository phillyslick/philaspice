class Price < ActiveRecord::Base
  belongs_to :variant
  belongs_to :weight
  attr_accessible :amount
end
