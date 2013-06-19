class Address < ActiveRecord::Base
  belongs_to :order
  attr_accessible :address1, :address2, :city, :kind, :state, :zip
  
end
