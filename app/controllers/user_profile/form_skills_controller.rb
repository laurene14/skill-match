module UserProfile
  class FormSkillsController < ApplicationController
    def new
      @form_skill = FormSkill.new
      authorize @form_skill
      @categories = Category.where(id: params[:categories][:name])
      # @skills = @categories.skills
      # raise
    end

    def create
      params[:user_profile_form_skill][:name].delete('')
      @form_skill_ids = params[:user_profile_form_skill][:name]
      @form_skill_ids.each do |skill_id|
        UserSkill.create(
          user: current_user,
          skill_id: skill_id,
          wanted: false
        )
      end
      redirect_to 
    end

    private

    def form_skill_params
      params.require(:user_profile_form_skill).permit(:name)
    end
  end
end
