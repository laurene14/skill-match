module UserProfile
  class UserSkillsController < ApplicationController
    before_action :set_category, only: %i[new,create]

    def new
      @user = current_user
      @skills = category.skills
    end

    def create
      @skill = Skill.new(user_skill_params)
    end

    private

    def user_skill_params
      params.require(:user_profile_user_skill).permit(:name)
    end

    def set_category
      @category = Category.find_by(name: params[:name])
    end
  end
end
