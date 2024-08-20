class Skill < ApplicationRecord
  has_one_attached :photo

  has_many :users, through: :user_skills
  has_many :categories, through: :skill_categories
  has_many :skill_categories

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 10 }
end
