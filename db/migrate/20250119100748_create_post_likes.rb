# frozen_string_literal: true

class CreatePostLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :post_likes, &:timestamps
  end
end
