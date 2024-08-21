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
        # TODO Redirect vers la prochaine step
        authorize @user_description
        redirect_to root_path
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
