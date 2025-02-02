require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    sign_in users(:test_user)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url(locale: :en), params: { post: { body: @post.body, title: @post.title, category_id: @post.category.id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post, locale: :en)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post, locale: :en)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post, locale: :en), params: { post: { body: @post.body, title: @post.title } }
    assert_redirected_to @post
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post, locale: :en)
    end

    assert_redirected_to posts_url
  end
end
