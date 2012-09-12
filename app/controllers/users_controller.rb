class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update]
  before_filter :find_user
  before_filter :big_adv, :medium_advs, :small_advs, :only => [:show, :draft, :edit]

  # show
  def show
    if current_user == @user
      @posts = @user.posts.order("renew DESC, created_at DESC").paginate(:page => params[:page])
    else
      @posts = @user.posts.all_published.paginate(:page => params[:page])
    end
  end

  # draft
  def draft
    authorize! :read_draft, @user
    @posts = @user.posts.where("status = 0").paginate(:page => params[:page])
    render :show
  end

  # edit
  def edit
  end

  # update
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your data has been updated"
      redirect_to user_path(@user.slug)
    else
      flash[:notice] = @user.errors.try(:full_messages).try(:join, '<br />')
      render :edit
    end
  end

  protected

    # find user
    def find_user
      @user = User.find_by_slug(params[:slug] || params[:id]) || User.find_by_id(params[:id])
    end
end
