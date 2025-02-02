require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    sign_in users(:test_user)
  end

  test "should create post like" do
    assert_difference("PostLike.count") do
      post post_likes_url(@post, locale: :en)
    end

    assert_redirected_to @post
  end

  test "should delete post like" do
    assert_difference("PostLike.count", -1) do
      delete post_likes_url(@post, locale: :en)
    end

    assert_redirected_to @post
  end
end
