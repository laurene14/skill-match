module UserProfile
  class FormSkillsController < ApplicationController

    def new
      @form_skill = FormSkill.new
      @categories = Category.where(id: params[:categories])
      authorize @form_skill

      # @skills = @categories.skills
      # raise
    end

    def create
      @form_skill = FormSkill.new(current_user: current_user, skill_ids: params[:user_profile_form_skill][:skill_ids])
      @categories = Category.where(id: params[:user_profile_form_skill][:category_ids].split(" "))
      authorize(@form_skill)

      if @form_skill.save
        redirect_to new_user_profile_user_wanted_skill_category_path
      else
        render :new, status: :unprocessable_entity, alert: 'You must select at least one category.'
      end
    end

    def edit
      @form_skill = FormSkill.new
      @categories = current_user.skills.joins(:categories).distinct.pluck(:name)
      authorize @form_skill
    end

    def update
      @form_skill = FormSkill.new(form_skill_params)
      authorize @form_skill

      if current_user.update(user_description_params)
          redirect_to user_profile_profile_path(current_user)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    if @form_skill.valid?
      if current_user.update(form_skill_params)
        redirect_to user_profile_profile_path(current_user)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private


    def form_skill_params
      params.require(:user_profile_form_skill).permit(:name)
    end
  end
end
