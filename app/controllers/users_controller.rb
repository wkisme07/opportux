class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update]
  before_filter :find_user

  # show
  def show
    @posts = @user.posts.order("renew, created_at DESC").paginate(:page => params[:page])
  end

  protected

    # find user
    def find_user
      @user = User.find_by_slug(params[:slug] || params[:id]) || User.find_by_id(params[:id])
    end
end
