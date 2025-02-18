# frozen_string_literal: true

class AddPostToPostComments < ActiveRecord::Migration[7.2]
  def change
    add_reference :post_comments, :post, null: false, foreign_key: { to_table: :posts }
  end
end
