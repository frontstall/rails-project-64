# frozen_string_literal: true

class AddCreatorToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :creator, null: false, foreign_key: { to_table: :users }
  end
end
