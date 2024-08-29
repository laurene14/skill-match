class ApplicationController < ActionController::Base
  add_flash_types :match
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, except: %i[index], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: %i[index], unless: :skip_pundit?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username address latitude longitude bio distance_preference])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer
      .permit(:account_update, keys: %i[username address latitude longitude bio distance_preference])
  end


  # Pundit: allow-list approach

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def after_sign_up_path_for(resources)
    new_user_profile_user_description_path
  end

  def after_sign_in_path_for(resources)
    new_user_profile_user_description_path
    if !current_user&.address
      new_user_profile_user_description_path
    elsif !current_user&.proposed_user_skills
      new_user_profile_user_skill_category_path
    elsif !current_user&.wanted_user_skills
      user_profile_user_wanted_skill_categories_path
    elsif !current_user&.distance_preference
      new_user_profile_user_distance_preference
    else
      likes_path
    end
  end

  private

  def skip_pundit?
    result = devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    logger.debug "skip_pundit? result: #{result}"
    result
  end
end
