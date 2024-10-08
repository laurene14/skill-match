module UserProfile
  class WantedFormSkillsController < ApplicationController

    def new
      @wanted_form_skill = WantedFormSkill.new

      @categories = Category.where(id: params[:user_profile_user_skill_category][:name])
      authorize @wanted_form_skill
    end

    def create
      @wanted_form_skill = WantedFormSkill.new(current_user: current_user, wanted_skill_ids: params[:user_profile_wanted_form_skill][:wanted_skill_ids])
      @categories = Category.where(id: params[:user_profile_wanted_form_skill][:category_ids].split(" "))
      authorize(@wanted_form_skill)

      if @wanted_form_skill.save
        redirect_to new_user_profile_user_distance_preference_path
        # redirect_to root_path
      else
        render :new, status: :unprocessable_entity, alert: 'You must select at least one category.'
      end
    end

    def edit
      @wanted_form_skill = WantedFormSkill.new
      @categories = Category.where(id: params[:categories])
      @existing_skills = current_user.wanted_skills
      authorize @wanted_form_skill
    end

    def update
      @wanted_form_skill = WantedFormSkill.new(current_user: current_user, wanted_skill_ids: params[:user_profile_wanted_form_skill][:skill_ids])
      @categories = Category.where(id: params[:user_profile_wanted_form_skill][:category_ids].split(" "))
      authorize @wanted_form_skill

      if @wanted_form_skill.valid?
        if @wanted_form_skill.save
          redirect_to user_profile_profile_path(current_user)
        else
          render :edit, status: :unprocessable_entity
        end
      end
    end


    private

    def wanted_form_skill_params
      params.require(:user_profile_wanted_form_skill).permit(:name)
    end
  end
end
