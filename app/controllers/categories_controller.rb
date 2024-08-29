class CategoriesController < ApplicationController
  def index
    @users = policy_scope(User)
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    authorize @category
    @skills = @category.skills
  end

  private

  def category_params
    params.require(:category).permit(:category_id)
  end
end
