module UserProfile
  class UserWantedSkillCategoriesController < ApplicationController
    before_action :authorize_user_wanted_skill_category, only: %i[new create]

    def new
      @user_wanted_skill_category = UserSkillCategory.new
      @categories = Category.all
      # authorize @user_wanted_skill_category
    end

    def create
      selected_category_ids = user_wanted_skill_category_params[:category_ids]

      if selected_category_ids.present?
        session[:selected_category_ids] = selected_category_ids
        redirect_to next_step_path
      else
        flash.now[:alert] = 'You must select at least one category.'
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @user_wanted_skill_category = UserWantedSkillCategory.new
      @categories = Category.all
      @existing_categories = current_user.wanted_skills.map(&:categories).flatten.uniq
      # >> current_user.proposed_skills.joins(:categories).distinct.map(&:categories).flatten.uniq

      # @categories = current_user.skills.joins(:categories).distinct.pluck(:name)
      authorize @user_wanted_skill_category
    end

    def update
      @user_wanted_skill_category = UserWantedSkillCategory.new(user_wanted_skill_category_params)

      authorize @user_wanted_skill_category

      if @user_wanted_skill_category.valid?
        redirect_to edit_user_profile_wanted_form_skill_path(id: current_user, categories: @user_wanted_skill_category.name)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def user_wanted_skill_category_params
      params.require(:user_profile_user_wanted_skill_category).permit(name: [], category_ids: [])
    end

    def authorize_user_wanted_skill_category
      authorize @user_wanted_skill_category || UserSkillCategory.new
    end
  end
end
