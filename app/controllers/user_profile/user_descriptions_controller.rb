module UserProfile
  class UserDescriptionsController < ApplicationController
    def new
      @user_description = UserDescription.new
      authorize @user_description
    end

    def create
      @user_description = UserDescription.new(user_description_params)
      if @user_description.valid?
        current_user.update(user_description_params)
        authorize @user_description
        redirect_to new_user_profile_user_skill_category_path
        # redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_description_params
      params.require(:user_profile_user_description).permit(:address, :bio)
    end
  end
end
