class UsersController < ApplicationController
  before_action :set_current_user_skills_preference, only: %i[index show]

  def index
    @likes = policy_scope(Like)
    @likeds = @likes.where(likes: { liker: current_user, wanted: true })
                    .joins(:liked)
                    .includes(liked: :proposed_skills)
                    .where.not(likes: { liked_id: current_user.matched_user_ids })
    @likers = @likes.where(likes: { liked: current_user, wanted: true })
                    .joins(:liker)
                    .includes(liker: :proposed_skills)
                    .where.not(likes: { liker_id: current_user.matched_user_ids })
  end

  def show
    @user = User.find(params[:id])
    @avatar = @user.photos.first
    authorize @user
    @skills = @user.skills
    @wanted_skills = @user.user_skills.where(wanted: true).map(&:skill)
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :status, :location, :bio, :distance_preference, :photos [])
  end

  def set_current_user_skills_preference
    @current_user_skills_preference = {
      wanted: current_user.wanted_skills.pluck(:name)
    }
  end

  def set_matched_ids
    User.joins(:likes_as_liked).where(likes: { liker: current_user }).select(:id)
  end
end
