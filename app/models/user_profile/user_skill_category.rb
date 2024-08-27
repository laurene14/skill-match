module UserProfile
  class UserSkillCategory
    include ActiveModel::Model

    attr_accessor :category_ids, :name, :current_user

    # validates :name, uniqueness: true
    validate :category_id_presence

    private

    def category_id_presence
      unless name
        errors.add(:name, "You must select at least one category")
      end
    end
  end
end
