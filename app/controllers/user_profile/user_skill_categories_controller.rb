module UserProfile
  class UserSkillCategoriesController < ApplicationController
    before_action :authorize_user_skill_category, only: %i[new create]

    def new
      @user_skill_category = UserSkillCategory.new
      @categories = Category.all
      # authorize @user_skill_category
    end

    def create
      @user_skill_category = UserSkillCategory.new(user_skill_category_params)
      # @user_skill_category = UserSkillCategory.new(name: params[:user_profile_user_skill_category][:name])

      if @user_skill_category.valid?
        redirect_to new_user_profile_form_skill_path(categories: @user_skill_category.name)
      else
        render :new, status: :unprocessable_entity
      end


    end

    private

    def user_skill_category_params
      params.require(:user_profile_user_skill_category).permit(name: [], category_ids: [])
    end

    def authorize_user_skill_category
      authorize @user_skill_category || UserSkillCategory.new
    end
  end
end
