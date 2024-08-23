module UserProfile
  class UserSkillCategoriesController < ApplicationController
    before_action :authorize_user_skill_category, only: %i[new create]

    def new
      @user_skill_category = UserSkillCategory.new
      @categories = Category.all
      # authorize @user_skill_category
    end

    def create
      selected_category_ids = user_skill_category_params[:category_ids]

      if selected_category_ids.present?
        session[:selected_category_ids] = selected_category_ids
        redirect_to next_step_path
      else
        flash.now[:alert] = 'You must select at least one category.'
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_skill_category_params
      params.require(:user_profile_user_skill_category).permit(category_ids: [])
    end

    def authorize_user_skill_category
      authorize @user_skill_category || UserSkillCategory.new
    end
  end
end
