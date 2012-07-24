class Post < ActiveRecord::Base
  has_many :post_images
  belongs_to :category
  belongs_to :city

  acts_as_ordered_taggable
  attr_accessible :user_id, :title, :image,
    :name, :email

  validates :user_id, :title, :category_id, :location_id, :presence => true

  before_save :complete_data

  # before save
  def complete_data
    self.status = 0 if self.status.blank?
  end

  # all published posts
  def self.all_published
    where('status = 1')
  end

  # images
  def images
    post_images
  end
end
