class PostsController < ApplicationController
  before_action :authenticate, except: :index

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.secrets.cms_username &&
      password == Rails.application.secrets.cms_password
    end

    session[:logged_in] = true

    return true
  end
end
