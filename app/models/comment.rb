class Comment < ApplicationRecord
  belongs_to :card
  belongs_to :user

  after_create_commit { broadcast_prepend_to("comments") }
end
