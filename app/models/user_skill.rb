class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  validates :wanted, inclusion: { in: [true, false], message: "must be true or false" }
  validates :user_id, uniqueness: {
    scope: %i[skill_id wanted], message: "combination of skill and wanted must be unique for each user"
  }
end
