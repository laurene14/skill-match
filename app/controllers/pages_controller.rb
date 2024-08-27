class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    redirect_to categories_path if current_user
  end
end
