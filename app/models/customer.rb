class Customer < ActiveRecord::Base
  attr_accessible :email, :first_name, :home_phone, :last_name, :work_phone, :company
  validates_presence_of :email, :first_name, :last_name, :home_phone


  def name
    [first_name, last_name].join(" ")
  end

end
