class HomeController < ApplicationController
  before_filter :tag_cloud, :only => [:business, :people]
  before_filter :find_post, :only => [:show, :show_info]
  before_filter :can_read_draft?, :only => [:show]
  before_filter :big_adv, :medium_advs, :small_advs, :only => [:index, :show, :business, :people, :content, :about, :contact]

  # front-page
  def index
    ps = params[:tag] ? Post.by_tags(tags).all_published : Post.search(params[:search])
    @posts  = ps.paginate(:page => params[:page])
  end

  # show detail post
  def show
    @post = Post.find_by_slug(params[:slug])
    @temp = params[:info] || 'description'

    @post.pviews.create(:user_id => current_user.try(:id), :ip_address => request.ip)
  end

  # change picture
  def photo
    @post = Post.find_by_slug(params[:slug])
    @pi = PostImage.find_by_id(params[:id])
    @temp = 'photo'
    render :show unless request.xhr?
  end

  # business
  def business
    if params[:tag]
      @posts = Post.by_tags(tags).all_published.by_business
    else
      @posts = Post.all_published.where("category_id = 1")
    end
    @posts = @posts.paginate(:page => params[:page])
    render :index
  end

  # people
  def people
    if params[:tag]
      @posts = Post.by_tags(tags).all_published.by_people
    else
      @posts = Post.all_published.where("category_id = 2")
    end
    @posts = @posts.paginate(:page => params[:page])
    render :index
  end

  # project
  def project
    if params[:tag]
      @posts = Post.by_tags(tags).all_published.by_project
    else
      @posts = Post.all_published.where("category_id = 3")
    end
    @posts = @posts.paginate(:page => params[:page])
    render :index
  end

  # how it works
  def content
    code = request.fullpath.gsub('/', '')
    @content = Content.find_by_code(code)
  end

  # about us
  def about
  end

  # contact us
  def contact
  end

  protected

    # can read draft
    def can_read_draft?
      if @post && @post.status != 1 && current_user.try(:id) != @post.user_id
        flash[:alert] = "You are not authorize to access this page."
        redirect_to root_path
      end
    end

    # tags
    def tags
      t = params[:tag].try(:downcase)
      t += "/reseller" if t.include?('agen')

      !t.blank? ? t.split(/\/|,|\+| /) << t : []
    end

end
