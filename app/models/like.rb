class Like < ApplicationRecord
  belongs_to :liker, class_name: "User"
  belongs_to :liked, class_name: "User"

  after_save :check_for_match
  after_save :check_for_unmatch

  validates :wanted, presence: true

  private

  def check_for_match
    reciprocal_like = Like.find_by(liker_id: liked_id, liked_id: liker_id, wanted: true)
    return unless reciprocal_like && wanted

    Match.find_or_create_by(user1_id: [liker_id, liked_id].min, user2_id: [liker_id, liked_id].max)
  end

  def check_for_unmatch
    reciprocal_like = Like.find_by(liker_id: liked_id, liked_id: liker_id)
    return unless reciprocal_like && !wanted

    match = Match.find_by(user1_id: [liker_id, liked_id].min, user2_id: [liker_id, liked_id].max)
    match&.destroy
  end
end
