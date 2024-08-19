class UsersController < ApplicationController
  def index
  end
  def show
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

end
