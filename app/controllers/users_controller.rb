class UsersController < ApplicationController
  def index
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :status, :location, :bio, :distance_preference, :photos [])
  end
end
