class PostsController < ApplicationController
# @author Wawan Kurniawan <ones07@gmail.com>
  before_filter :find_post, :only => [:edit, :update, :show, :destroy, :review, :publish]

  # new post
  def new
    @post = Post.new
  end

  # save post
  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = "Upload success"
      redirect_to review_posts_path(@post)
    else
      render :action => :new
    end
  end

  # review post before publish it
  def review
  end

  # publish post
  def publish
    if @post.update_attribute('status', 1)
      flash[:notice] = "Upload saved"
      redirect_to root_path
    else
      flash[:notice] = "Save failed"
      redirect_to review_posts_path(@post)
    end
  end

  # show post
  def show
  end

  # edit post
  def edit
  end

  # update post
  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = "Saved"
      redirect_to review_posts_path(@post)
    else
      flash[:notice] = "Save failed"
      redirect_to root_path(@post)
    end
  end

  # remove post
  def destroy
    flash[:notice] = @post.destroy ? 'Removed' : 'Failed to remove'
    redirect_to root_path
  end

protected
  
  # find post
  def find_post
    @post = Post.find_by_id(params[:id])
  end
end
