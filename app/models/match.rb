class Match < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  scope :involving, lambda { |user|
    where("user1_id = :user_id OR user2_id = :user_id", user_id: user.id)
  }
end
