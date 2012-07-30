class HomeController < ApplicationController
  before_filter :tag_cloud

  # front-page
  def index
    @posts = Post.all_published
  end

  # show detail post
  def show
    @post = Post.find_by_slug(params[:slug])

    @post.pviews.create(:user_id => current_user.try(:id), :ip_address => request.ip) if can_view?(@post)
  end

  # detail info
  def show_info
    @post = Post.find_by_slug(params[:slug])
    @temp = params[:info]
  end

  # business
  def business
    @posts = Post.all_published.where("category_id = 1")
    render :index
  end

  # people
  def people
    @posts = Post.all_published.where("category_id = 2")
    render :index
  end
end
