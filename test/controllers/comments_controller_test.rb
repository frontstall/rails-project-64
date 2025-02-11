require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    sign_in users(:test_user)
  end

  test "should create post comment" do
    assert_difference("PostComment.count") do
      post post_comments_url(@post), params: { post_comment: { content: "First comment" } }
    end

    assert_redirected_to @post
  end

  test "should create reply to comment" do
    assert_difference("PostComment.count") do
      post post_comments_url(@post), params: { post_comment: { content: "Reply to comment", parent_id: post_comments(:one).id } }
    end

    assert_redirected_to @post
  end
end
