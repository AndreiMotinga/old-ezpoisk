class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action do
    if current_user && current_user.is_admin?
      Rack::MiniProfiler.authorize_request
    end
  end

  private

  def get_record(model, id, path)
    record = model.find_by_id(id)
    return record if record && record.active
    redirect_to path, alert: I18n.t(:post_not_found)
  end

  protected

  def address_changed?(record, prms)
    return true if record.try(:street) != prms[:street]
    return true if record.state_id != prms[:state_id].to_i
    return true if record.city_id != prms[:city_id].to_i
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(fields) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(fields) }
  end

  def fields
    [:name, :phone, :email, :password, :slug, :state_id, :city_id, :lat, :lng,
     :password_confirmation, :remember_me, :current_password, :avatar]
  end

end
