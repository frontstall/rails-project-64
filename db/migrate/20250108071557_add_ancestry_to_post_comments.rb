# frozen_string_literal: true

class AddAncestryToPostComments < ActiveRecord::Migration[7.2]
  def change
    if Rails.env.production?
      add_column :post_comments, :ancestry, :string, collation: 'C', null: false
    else
      add_column :post_comments, :ancestry, :string, null: false
    end

    add_index :post_comments, :ancestry
  end
end
