class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  mount_uploader :picture, ImageUploader
end

