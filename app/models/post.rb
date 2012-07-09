class Post < ActiveRecord::Base
  attr_accessible :user_id, :title, :image,
    :name, :email

  mount_uploader :image, ImageUploader
  validates :title, :image, :name, :email, :presence => true

  before_save :complete_data

  # before save
  def complete_data
    self.status = 0 if self.status.blank?
  end

  # all published posts
  def self.all_published
    where('status = 1')
  end
end
