class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :redirect_if_guest, only: %i[ create edit update destroy ]
  before_action :redirect_if_not_authorized, only: %i[ edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
    @can_edit = user_is_post_creator?
    @can_delete  = user_is_post_creator?
    @comment = PostComment.new
    @comments = @post.comments.select { |comment| comment.parent.nil? }
    @likes_count = @post.likes.count
    @like = @post.likes.find_by(user_id: current_user.id) if user_signed_in?
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!

    redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed."
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :category_id)
    end

    def redirect_if_guest
      redirect_to new_user_session_url unless user_signed_in?
    end

    def redirect_if_not_authorized
      render :show, status: :unauthorized unless user_is_post_creator?
    end

    def user_is_post_creator?
      user_signed_in? && @post.creator.id == current_user.id
    end
end
