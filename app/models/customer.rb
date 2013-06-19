class Customer < ActiveRecord::Base
  attr_accessible :email, :first_name, :home_phone, :last_name, :work_phone
end
