class PostComment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  belongs_to :post

  has_ancestry

  validates :content, presence: true, length: { minimum: 3 }
end
