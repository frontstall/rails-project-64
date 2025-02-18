# frozen_string_literal: true

class AddAuthorToPostComments < ActiveRecord::Migration[7.2]
  def change
    add_reference :post_comments, :author, null: false, foreign_key: { to_table: :users }
  end
end
