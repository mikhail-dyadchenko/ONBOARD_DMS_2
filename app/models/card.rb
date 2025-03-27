class Card < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  belongs_to :user
  has_many :comments
  mount_uploader :img, ImgUploader
end
