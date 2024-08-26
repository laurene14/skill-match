class UserProfile::ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @avatar = @user.photos.first
    authorize @user
    @skills = @user.skills
    @wanted_skills = @user.user_skills.where(wanted: true).map(&:skill)
  end
end
