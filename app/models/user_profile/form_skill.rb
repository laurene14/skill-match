module UserProfile
  class FormSkill
    include ActiveModel::Model

    attr_accessor :skill_ids, :category_ids, :current_user

    # validates :skill_ids, presence: true
    validate :skill_id_presence

    def save
      if valid?
        ActiveRecord::Base.transaction do
          skill_ids.each do |skill_id|
            UserSkill.create(
              user: current_user,
              skill_id: skill_id,
              wanted: false
            )
          end
        end
      else
        false
      end
    end

    def skill_id_presence
      unless skill_ids
        errors.add(:skill_ids, "You must select at least one skill")
      end
    end
  end
end
