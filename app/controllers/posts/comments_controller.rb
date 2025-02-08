class Posts::CommentsController < Posts::ApplicationController
  before_action :set_comment, only: %i[ edit update destroy ]
  before_action :redirect_if_guest, only: %i[ create edit update destroy ]
  before_action :redirect_if_not_authorized, only: %i[ edit update destroy ]

  def edit; end

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.build(comment_params)
    parent_id = comment_params[:parent_id]
    comment.parent = PostComment.find(parent_id) if parent_id

    comment.user = current_user

    if comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      flash[:failure] = comment.errors.first.full_message
      redirect_to @post
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.post, notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = @comment.post
    @comment.destroy!

    redirect_to post, status: :see_other, notice: "Comment was successfully deleted."
  end

  private

    def set_comment
      @comment = PostComment.find(params[:id])
    end

    def comment_params
      params.require(:post_comment).permit(:user_id, :post_id, :content, :parent_id)
    end

    def redirect_if_guest
      redirect_to new_user_session_url unless user_signed_in?
    end

    def redirect_if_not_authorized
      render :show, status: :unauthorised unless user_is_comment_author?
    end

    def user_is_comment_author?
      @comment.user.id == current_user.id
    end
end
