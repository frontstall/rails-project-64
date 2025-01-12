class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :redirect_if_guest, only: %i[ create edit update destroy ]
  before_action :redirect_if_not_authorized, only: %i[ edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
    @comment = PostComment.new
    @comments = @post.comments.select { |comment| comment.parent.nil? }
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
      render :show, status: :unauthorised unless user_is_post_creator?
    end

    def user_is_post_creator?
      @post.creator.id == current_user.id
    end
end
