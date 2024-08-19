class Category < ApplicationRecord
  has_one_attached :photo

  has_many :skills, through: :skill_categories

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 10 }
end
