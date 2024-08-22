module UserProfile
  class FormSkillsController < ApplicationController
    def new
      @user_skill = UserSkill.new
      authorize @user_skill
      @categories = Category.where(id: params[:categories][:name])
      # @skills = @categories.skills
      # raise
    end

    def create
      authorize @user_skill_ids
      @user_skill_ids = UserSkill.new(form_skill_params)
      raise
    end

    private

    def form_skill_params
      params.require(:user_profile_form_skill).permit(:name)
    end
  end
end
