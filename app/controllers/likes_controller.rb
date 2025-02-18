# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_like, only: %i[destroy]
  before_action :set_post, only: %i[create destroy]
  before_action :redirect_if_guest, only: %i[create destroy]
  before_action :redirect_if_not_authorized, only: %i[destroy]

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
    if @like.destroy
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
    @post = Post.find params[:post_id]
  end

  def set_like
    @like = PostLike.find params[:id]
  end

  def redirect_if_not_authorized
    redirect_to new_user_session_url unless user_is_like_creator?
  end

  def user_is_like_creator?
    @like.user.id == current_user.id
  end
end
