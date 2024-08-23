module UserProfile
  class FormSkillsController < ApplicationController

    def new
      @form_skill = FormSkill.new
      @categories = Category.where(id: params[:categories][:name])
      authorize @form_skill

      # @skills = @categories.skills
      # raise
    end

    def create
      @form_skill = FormSkill.new(current_user: current_user, skill_ids: params[:user_profile_form_skill][:skill_ids])
      @categories = Category.where(id: params[:user_profile_form_skill][:category_ids].split(" "))
      authorize(@form_skill)

      if @form_skill.save
        redirect_to user_wanted_skill_path
      else
        render :new, status: :unprocessable_entity, alert: 'You must select at least one category.'
      end
    end

    private


    def form_skill_params
      params.require(:user_profile_form_skill).permit(:name)
    end
  end
end
