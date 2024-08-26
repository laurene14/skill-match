module UserProfile
  class UserSkillCategory
    include ActiveModel::Model

    attr_accessor :category_ids, :name, :current_user

    validate :category_id_presence

    # def save
    #   if valid?
    #     ActiveRecord::Base.transaction do
    #       category_ids.each do |category_id|

    #       end
    #     end
    # end

    private

    def category_id_presence
      unless name
        errors.add(:name, "You must select at least one category")
      end
    end
  end
end
