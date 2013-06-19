class Address < ActiveRecord::Base
  belongs_to :order
  attr_accessible :address1, :address2, :city, :kind, :state, :zip
  validates_presence_of :address1, :city, :kind, :state, :zip
end
