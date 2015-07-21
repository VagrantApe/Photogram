class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def new
    @post = Post.create
  end

  def create
    if @post = Post.create(post_params)
      flash[:success] = "Your post has been created"
      redirect_to posts_path
    else
      flash[:alert] = "Your post could not be created, check your form entries"
      render :new
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Your post has been updated"
      redirect_to post_path
    else
      flash[:alert] = "Update FAILED, check your form entries"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Your post has been deleted"
      redirect_to root_path
    else
      flash[:alert] = "Destroy FAILED, kill yourself"
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
