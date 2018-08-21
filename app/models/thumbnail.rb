class Thumbnail < ApplicationRecord
  validates :image, presence: true
  mount_uploader :image, ThumbnailUploader
  belongs_to :picture
end
