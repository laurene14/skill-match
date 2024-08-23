class UsersController < ApplicationController
  before_action :set_current_user_skills_preference, only: %i[index show]

  def index
    @users = policy_scope(User)
    @users = @users.where.not(id: current_user.matched_user_ids)
    @users_list = []
    @users_list << @users
                   .joins(:likes_as_liker)
                   .where(likes: { liked: current_user })
                   .includes(:proposed_skills)
    @users_list << @users
                   .joins(:likes_as_liked)
                   .where(likes: { liker: current_user })
                   .includes(:proposed_skills)
  end

  def show
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
