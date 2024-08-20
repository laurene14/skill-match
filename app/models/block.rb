class Block < ApplicationRecord
  belongs_to :blocker, class_name: "User"
  belongs_to :blocked, class_name: "User"

  after_create :disconnect_with_blocked

  private

  def disconnect_with_blocked
    old_like = Like.find_by(liker_id: blocker_id)
    return unless old_like

    old_like.update(wanted: false)
  end
end
