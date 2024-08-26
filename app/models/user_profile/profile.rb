module UserProfile
  class Profile
    include ActiveModel::Model
    attr_accessor :bio, :address, :photos, :skill_ids, :wanted_skill_ids
  end
end
