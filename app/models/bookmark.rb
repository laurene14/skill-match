class Bookmark < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  validates :follower, uniqueness: {
    scope: %i[following], message: "Cannot have 2 entries for the same follower - following group"
  }
end
