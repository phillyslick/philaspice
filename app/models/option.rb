class Option < ActiveRecord::Base
  belongs_to :product
  attr_accessible :image, :product_id, :cat_info, :cat_heading
  
  mount_uploader :image, ImageUploader
end
