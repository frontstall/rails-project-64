class LikesController < ApplicationController
  before_action :redirect_if_guest, only: %i[ create destroy ]
  before_action :set_post, only: %i[ create destroy ]

  def create
    like = PostLike.new
    like.user = current_user
    like.post = @post

    if like.save
      redirect_to @post
    else
      redirect_to @post, status: :unprocessable_entity
    end
  end

  def destroy
    like = PostLike.find_by(post_id: @post.id, user_id: current_user.id)

    redirect_to new_user_session_url if like.nil?

    if like.destroy
      redirect_to @post
    else
      redirect_to @post, status: :unprocessable_entity
    end
  end

  private

  def redirect_if_guest
    redirect_to new_user_session_url unless user_signed_in?
  end

  def set_post
    @post = Post.find_by(params[:post_id])
  end
end
