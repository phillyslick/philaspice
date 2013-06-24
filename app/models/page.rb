class Page < ActiveRecord::Base
  attr_accessible :content, :image, :name, :slug, :title
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  mount_uploader :image, ImageUploader
  
end

