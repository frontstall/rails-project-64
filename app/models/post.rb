class Post < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :category
  has_many :comments, dependent: :destroy, class_name: "PostComment"
  has_many :likes, dependent: :destroy, class_name: "PostLike"

  validates :title, presence: true, length: { minimum: 3, maximum: 256 }
  validates :body, presence: true
end
