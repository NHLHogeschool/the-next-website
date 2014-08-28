module Admin
  class PostsController < ApplicationController
    before_action :authenticate

    def index
      @posts = Post.order('created_at desc').all
    end

    def show
      @post = Post.find(params[:id])
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

    def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to @post
      else
        render :edit
      end
    end

    def destroy
      post = Post.find(params[:id])
      post.destroy
      redirect_to posts_path
    end

    private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        if username == Rails.application.secrets.cms_username &&
           password == Rails.application.secrets.cms_password
          session[:logged_in] = true
        else
          false
        end
      end
    end
  end
end
