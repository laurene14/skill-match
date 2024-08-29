class Match < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  has_one :chatroom, dependent: :destroy
  has_many :messages, dependent: :destroy

  # after_create :create_chatroom, if: :saved_change_to_id?

  scope :involving, lambda { |user|
    where("user1_id = :user_id OR user2_id = :user_id", user_id: user.id)
  }

  private

  def create_chatroom
    Chatroom.create(match: self)
  end
end
