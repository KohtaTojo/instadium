class Picture < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :thumbnails, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :thumbnails, allow_destroy: true, reject_if: :all_blank
  def favorite_user(user_id)
    favorites.find_by(user_id: user_id)
  end
end
