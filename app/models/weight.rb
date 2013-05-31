class Weight < ActiveRecord::Base
  attr_accessible :ounces
  
  validates_presence_of :ounces
  
  def pounds
    (ounces / 16).to_f.round(4)
  end

end
