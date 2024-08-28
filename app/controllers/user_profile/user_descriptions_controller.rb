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

    def edit
      @user_description = UserDescription.new(address: current_user.address, bio: current_user.bio)
      authorize @user_description
    end

    def update
      @user_description = UserDescription.new(user_description_params)
      authorize @user_description
      if @user_description.valid?
        if current_user.update(user_description_params)
          redirect_to user_profile_profile_path(current_user)
        else
          render :edit, status: :unprocessable_entity
        end
      end
    end

    private

    def user_description_params
      params.require(:user_profile_user_description).permit(:address, :bio, photos: [])
    end
  end
end
