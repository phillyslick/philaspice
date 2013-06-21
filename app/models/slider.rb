class Slider < ActiveRecord::Base
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :name, :picture, :position, :published, :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :picture, PictureUploader
  
  after_update :crop_slider
  
  def crop_slider
    picture.recreate_versions! if crop_x.present?
  end
  
end
