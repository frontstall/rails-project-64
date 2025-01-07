class Post < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :category
  has_many :comments, dependent: :destroy, class_name: "PostComment"

  validates :title, presence: true, length: { minimum: 3, maximum: 256 }
  validates :body, presence: true
end
