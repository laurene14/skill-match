class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address, if: :should_geocode?
  after_validation :geocode, if: :will_save_change_to_address?

  has_many_attached :photos

  has_many :skills, through: :user_skills

  has_many :likes_as_liker, class_name: 'Match', add_foreign_key: 'liker_id'
  has_many :likes_as_liked, class_name: 'Match', add_foreign_key: 'liker_id'

  has_many :matches_as_user1, class_name: 'Match', foreign_key: 'user1_id'
  has_many :matches_as_user2, class_name: 'Match', foreign_key: 'user2_id'

  has_many :blocks_as_blocker, class_name: 'Blocks', foreign_key: 'blocker'
  has_many :blocks_as_blocked, class_name: 'Blocks', foreign_key: 'blocked'

  has_many :bookmarks_as_follower, class_name: 'Bookmark', foreign_key: 'follower_id'
  has_many :bookmarks_as_following, class_name: 'Bookmark', foreign_key: 'following_id'

  has_many :chatrooms, through: :matches

  validates :username, presence: true, uniqueness: true
  validate :validate_bio

  validates :distance_preference, presence: true, default: 3, numericality: {
    gerater_than_or_equal_to: 3, message: "must bigger than 3 km"
  }

  private

  # retrieve all matches involving a specific user, regardless of whether they are user1 or user2
  def matches_as_user
    Match.involving(self)
  end

  def should_geocode?
    latitude.blank? || longitude.blank?
  end

  def validate_bio
    validate_field_cannot_have_only_whitespace(:bio, min_length: 10)
  end
end
