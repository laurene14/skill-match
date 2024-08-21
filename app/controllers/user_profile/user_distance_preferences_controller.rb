module UserProfile
  class UserDistancePreferencesController < ApplicationController
    def new
      @user_distance_preference = UserDistancePreference.new
      authorize @user_distance_preference
    end

    def create

    end
  end
end
