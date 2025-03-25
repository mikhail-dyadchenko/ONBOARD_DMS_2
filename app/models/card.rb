class Card < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  has_many :comments, dependent: :destroy
  belongs_to :user
  mount_uploader :img, ImgUploader
end
