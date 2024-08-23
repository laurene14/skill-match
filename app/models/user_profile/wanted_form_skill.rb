module UserProfile
  class WantedFormSkill
    include ActiveModel::Model

    attr_accessor :wanted_skill_ids, :category_ids, :current_user

    # validates :skill_ids, presence: true
    validate :wanted_skill_id_presence

    def save
      if valid?
        ActiveRecord::Base.transaction do
          wanted_skill_ids.each do |wanted_skill_id|
            UserSkill.create(
              user: current_user,
              skill_id: wanted_skill_id,
              wanted: true
            )
          end
        end
      else
        false
      end
    end

    def wanted_skill_id_presence
      unless wanted_skill_ids
        errors.add(:wanted_skill_ids, "You must select at least one skill")
      end
    end
  end
end
