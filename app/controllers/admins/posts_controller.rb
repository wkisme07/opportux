class Admins::PostsController < Admins::ApplicationController
  before_filter :find_post, :only => [:destroy]

  # all posts
  def index
    @posts = Post.all_published.paginate(:page => params[:page])
  end

  # destroy
  def destroy
    if @post && @post.destroy
      flash[:notice] = "Post is removed"
    else
      flash[:alert] = "Failed to remove post"
    end

    redirect_to admins_posts_path
  end
end
