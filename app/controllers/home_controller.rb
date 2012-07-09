class HomeController < ApplicationController

  # shos all posts
  def index
    @posts = Post.all_published
    @top_thumbs = @posts
    @top_commented = @posts.slice(0, 5)
  end
end
