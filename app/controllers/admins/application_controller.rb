class Admins::ApplicationController < ApplicationController
  WillPaginate.per_page = 40
  layout 'admin'
  before_filter :authenticate_admin!
  before_filter :find_post, :only => [:destroy]

  # dashboard
  def dashboard
    @rposts = Post.joins(:post_reports).group('posts.id').order("COUNT(post_reports.id) DESC, posts.created_at DESC").
      paginate(:page => params[:page])
  end

  # remove post
  def destroy
    if @post && @post.destroy
      flash[:notice] = "Post is removed"
    else
      flash[:alert] = "Failed to remove post"
    end

    redirect_to admin_root_path
  end
end
