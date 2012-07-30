class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :top_thumbs, :top_views, :city_options, :category_options, :can_like?, :can_view?, :can_renew?

  http_basic_authenticate_with :name => "opportux", :password => "123opportux"

protected

  # top thumbs
  def top_thumbs
    @top_thumbs = Post.where("status = 1").order('created_at DESC').limit(4)
  end

  # top views
  def top_views
    @top_views = Post.joins(:pviews).group('posts.id').order('COUNT(pviews.id) DESC').limit(5)
  end

  # city options
  def city_options
    @city_options = City.where("country_id = 114").collect{|c| [c.name, c.id] }
  end

  # cateogory options
  def category_options
    @category_options = Category.all.collect{|c| [c.name, c.id] }
  end

  # tags
  def tag_cloud
    @tags = Post.tag_counts_on(:tags)
  end

  # can like?
  def can_like?(post)
    likes = post.likes
    likes.blank? || (current_user ? !likes.map(&:user_id).include?(current_user.id) : !likes.map(&:ip_address).include?(request.ip))
  end

  # can view?
  def can_view?(post)
    pviews = post.pviews
    pviews.blank? || (current_user ? !pviews.map(&:user_id).include?(current_user.id) : !pviews.map(&:ip_address).include?(request.ip))
  end

  # can renew
  def can_renew?(post)
    post.published? && post.renew.to_date != Date.today
  end
end
