module UserProfile
  class UserDistancePreferencesController < ApplicationController
    def new
      @user_distance_preference = UserDistancePreference.new
      authorize @user_distance_preference
    end

    def create
      @user_distance_preference = UserDistancePreference.new(user_distance_preference_params)
      if @user_distance_preference.valid?
        current_user.update(user_distance_preference_params)
        authorize @user_distance_preference
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_distance_preference_params
      params.require(:user_profile_user_distance_preference).permit(:distance_preference)
    end
  end
end
