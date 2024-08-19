class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :conditionally_geocode

  has_many_attached :photos

  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills

  has_many :likes_as_liker, class_name: 'Like', foreign_key: 'liker_id', dependent: :destroy
  has_many :likes_as_liked, class_name: 'Like', foreign_key: 'liker_id', dependent: :destroy

  has_many :matches_as_user1, class_name: 'Match', foreign_key: 'user1_id', dependent: :destroy
  has_many :matches_as_user2, class_name: 'Match', foreign_key: 'user2_id', dependent: :destroy

  has_many :blocks_as_blocker, class_name: 'Block', foreign_key: 'blocker', dependent: :destroy
  has_many :blocks_as_blocked, class_name: 'Block', foreign_key: 'blocked', dependent: :destroy

  has_many :bookmarks_as_follower, class_name: 'Bookmark', foreign_key: 'follower_id', dependent: :destroy
  has_many :bookmarks_as_following, class_name: 'Bookmark', foreign_key: 'following_id', dependent: :destroy

  has_many :chatrooms, through: :matches, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validate :validate_bio

  validates :address, presence: true
  validates :distance_preference, presence: true, numericality: {
    greater_than_or_equal_to: 3, message: "must bigger than 3 km"
  }

  private

  def matches_as_user
    # retrieve all matches involving a specific user, regardless of whether they are user1 or user2
    Match.involving(self)
  end

  def conditionally_geocode
    # Check if the latitude and longitude are not set (for create)
    # Check if the address has changed (for update)
    return unless (latitude.blank? && longitude.blank?) || will_save_change_to_address?

    geocode
  end

  def validate_bio
    validate_field_cannot_have_only_whitespace(:bio, min_length: 10)
  end
end
