class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name
  #   devise_parameter_sanitizer.for(:account_update) << :first_name << :last_name
  # end

  include Pundit

  protect_from_forgery with: :exception

  private

    def allowed_to_approve!
      authenticate_user!
      unless current_user.admin? || (['approver', 'owner'].include? current_user.role)
        flash[:alert] = "You must be an approver to do that."
        redirect_to root_path
      end
    end  

end
