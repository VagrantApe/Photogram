class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def show
  end

  def edit
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
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
    @post.destroy
    flash[:success] = "Your post has been deleted"
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "No way Jose"
      redirect_to root_path
    end
  end
end
