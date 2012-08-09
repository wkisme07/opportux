class HomeController < ApplicationController
  before_filter :tag_cloud
  before_filter :find_post, :only => [:show, :show_info]
  before_filter :can_read_draft?, :only => [:show]

  # front-page
  def index
    ps = params[:tag] ? Post.all_published.tagged_with(params[:tag], :wild => true) : Post.search(params[:search])
    @posts  = ps.paginate(:page => params[:page])
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
    @posts = Post.all_published.where("category_id = 1").paginate(:page => params[:page])
    render :index
  end

  # people
  def people
    @posts = Post.all_published.where("category_id = 2").paginate(:page => params[:page])
    render :index
  end

  protected

    # can read draft
    def can_read_draft?
      if @post && @post.status != 1 && current_user.try(:id) != @post.user_id
        flash[:alert] = "You are not authorize to access this page."
        redirect_to root_path
      end
    end
end
