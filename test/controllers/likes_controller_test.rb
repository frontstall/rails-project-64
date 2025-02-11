require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:test_user)
  end

  test "should create post like" do
    post = posts(:two)
    assert_difference("PostLike.count") do
      post post_likes_url post.id
    end

    assert_redirected_to post
  end

  test "should delete post like" do
    post = posts(:one)
    like = post_likes(:one)

    assert_difference("PostLike.count", -1) do
      post post_like_url(post.id, like.id)
    end

    assert_redirected_to post
  end
end
