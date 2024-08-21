module UserProfile
  class UserDescription
    include ActiveModel::Model

    attr_accessor :address, :bio
  end
end
