class CreatePostLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :post_likes do |t|
      t.timestamps
    end
  end
end
