class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :city
  belongs_to :user
  has_many :post_images
  has_many :likes
  has_many :pviews
  has_many :post_reports

  acts_as_ordered_taggable
  attr_accessible :user_id, :slug, :status, :title, :tag_list,
    :category_id, :city_id, :description, :deal, :created_at, :updated_at,
    :renew, :view, :like, :report, :post_images_attributes

  validates :user_id, :title, :category_id, :city_id, :description, :presence => true
  validate :require_main_image

  accepts_nested_attributes_for :post_images, :reject_if => lambda {|pi| pi['image'].blank? }, :allow_destroy => true

  before_save :complete_data

  def require_main_image
    errors.add(:base, "You must provide at least one image") if images.blank?
  end

  # before save
  def complete_data
    self.status = 0 if self.status.blank?
    self.slug = Digest::SHA1.hexdigest(Time.now.to_s).slice(0, 8) if self.slug.blank?
    self.renew = self.created_at if self.renew.blank?
  end

  # all published posts
  def self.all_published
    where('status = 1').order('renew DESC, created_at DESC')
  end

  def self.search(params)
    term = !params.blank? && !params[:term].blank? ? params[:term] : ''

    unless term.blank?
      where(["status = 1 AND (title LIKE ? OR description LIKE ? OR
        id IN (SELECT taggable_id FROM taggings WHERE taggable_type = 'Post' AND tag_id IN
          (SELECT id FROM tags WHERE name LIKE ?))
      )", "%#{term}%", "%#{term}%", "%#{term}%"]).order('renew DESC')
    else
      all_published
    end
  end

  # alias
  alias :location :city
  alias :views :pviews
  alias :reports :post_reports

  # like
  def like
    likes.try(:count) || 0
  end

  # view
  def view
    pviews.try(:count) || 0
  end

  # images
  def images
    post_images
  end

  # main image
  def main_image
    images.find_by_main_image(1) || images.try(:first)
  end

  # published?
  def published?
    status == 1
  end
end
