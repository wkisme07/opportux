class PostImage < ActiveRecord::Base
  belongs_to :post

  attr_accessible :post_id, :image, :main_image
  mount_uploader :image, ImageUploader

end
