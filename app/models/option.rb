class Option < ActiveRecord::Base
  belongs_to :product
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :image, :product_id, :cat_info, :cat_heading, 
                  :crop_x, :crop_y, :crop_w, :crop_h
  
  mount_uploader :image, ImageUploader
  after_update :crop_image
  
  def crop_image
    image.recreate_versions! if crop_x.present?
  end
end
