class PostsController < ApplicationController
  respond_to :html, :atom

  def index
    @posts = Post.order('created_at desc').all
    respond_with @posts
  end

  def show
    @post = Post.find(params[:id])
  end
end
