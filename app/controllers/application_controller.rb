class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #todo  authorize dashboard here
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def geo_scope(records)
    records.within(params[:within],
                   origin: params[:origin])
  end

  def geo_scoped_params?
    !params[:within].blank? && !params[:origin].blank?
  end

  protected

  #todo: refactor
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :phone, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :phone, :email, :password, :password_confirmation, :current_password) }
  end
end
