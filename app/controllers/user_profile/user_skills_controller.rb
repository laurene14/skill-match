module UserProfile
  class UserSkillsController < ApplicationController
    def new
      @user_skill = UserSkill.new
      authorize @user_skill
      @categories = Category.where(id: params[:categories][:name])
      # @skills = @categories.skills
      # raise
    end

    def create
      authorize @user_skill
      @user_skill = UserSkill.new(user_skill_params)
    end

    private

    def user_skill_params
      params.require(:user_profile_user_skill).permit(:name)
    end

    def set_category
      @category = Category.find_by(name: params[:id])
    end
  end
end
