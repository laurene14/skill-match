class Like < ApplicationRecord
  belongs_to :liker, class_name: "User"
  belongs_to :liked, class_name: "User"

  after_save :check_for_match
  after_save :check_for_unmatch
  after_destroy :check_for_unmatch

  validates :wanted, inclusion: { in: [true, false], message: "must be true or false" }

  validates :liker, uniqueness: {
    scope: %i[liked], message: "Cannot have 2 entries for the same liker - liked group"
  }

  private

  def check_for_match
    reciprocal_like = Like.find_by(liker_id: liked_id, liked_id: liker_id, wanted: true)
    if reciprocal_like && wanted
      match = Match.find_or_create_by(user1_id: [liker_id, liked_id].min, user2_id: [liker_id, liked_id].max)
      if match.persisted?
        Notification.create(user: liked, content: "#{liker.username} starts to match with you.")
        Notification.create(user: liker, content: "#{liked.username} starts to match with you.")
      end
    else
      Notification.create(user: liked, content: "#{liker.username} likes you.")
    end
  end

  def check_for_unmatch
    reciprocal_like = Like.find_by(liker_id: liked_id, liked_id: liker_id)
    return unless reciprocal_like && !wanted

    match = Match.find_by(user1_id: [liker_id, liked_id].min, user2_id: [liker_id, liked_id].max)
    match&.destroy
  end
end
