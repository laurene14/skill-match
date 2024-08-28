class UserProfile::ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @avatar = @user.photos.first
    authorize @user
    @skills = @user.proposed_skills
    @wanted_skills = @user.wanted_skills
  end

  def update_photos
    @user = current_user
    if @user.update(user_params)
      redirect_to user_profile_profile_path(current_user), notice: "Photos updated successfully"
    else
      render :show, alert: "Failed to upload photos"
    end
  end

  def destroy_photo
    @user = current_user
    photo = @user.photos.find(params[:id])
    photo.purge # Assuming Active Storage is used
    authorize @photo
    redirect_to user_profile_profile_path(current_user), notice: "Photo deleted successfully"
  end

  private

  def user_params
    params.require(:user).permit(photos: [])
  end

end
