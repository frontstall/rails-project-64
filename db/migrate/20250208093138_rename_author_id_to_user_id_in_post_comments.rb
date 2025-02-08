class RenameAuthorIdToUserIdInPostComments < ActiveRecord::Migration[7.2]
  def change
    rename_column :post_comments, :author_id, :user_id
  end
end
