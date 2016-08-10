class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_rack_mini_profiler
  before_action :redirect_to_https

  private

  def redirect_to_https
    return unless Rails.env.production?
    redirect_to protocol: "https://" unless request.ssl? || request.local?
  end

  def check_rack_mini_profiler
    # Rack::MiniProfiler.authorize_request if current_user.try(:admin)
  end

  def get_record(model, id, path)
    record = model.find(id) if model.exists?(id)
    return record if record && record.active?
    redirect_to path, alert: I18n.t(:post_not_found)
  end

  protected

  def create_subscription(record)
    Subscription.create(
      user: current_user,
      subscribable_id: record.id,
      subscribable_type: record.class.to_s
    )
  end

  def address_changed?(record, prms)
    return true if record.try(:street) != prms[:street]
    return true if record.state_id != prms[:state_id].to_i
    return true if record.city_id != prms[:city_id].to_i
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: fields)
    devise_parameter_sanitizer.permit(:account_update, keys: fields)
  end

  def fields
    [:name, :phone, :email, :password, :slug, :state_id, :city_id, :lat, :lng,
     :password_confirmation, :remember_me, :current_password, :avatar, :site]
  end
end
