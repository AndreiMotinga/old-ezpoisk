class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :set_location
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_rack_mini_profiler
  before_action :redirect_to_https

  private

  def set_location
    return if Rails.env.test?
    return if session[:state_id]
    data = Geokit::Geocoders::MultiGeocoder.geocode("67.80.0.147")
    # data = Geokit::Geocoders::MultiGeocoder.geocode(request.remote_ip)
    state = State.find_by_abbr(data.state)
    if state
      city = state.cities.find_by_name(data.city)
      session[:state_id] = state.id
      session[:city_id] = city.id
    else
      session[:state_id] = 0
      session[:city_id] = 0
    end
  end


  def redirect_to_https
    return unless Rails.env.production?
    redirect_to protocol: "https://" unless (request.ssl? || request.local?)
  end

  def check_rack_mini_profiler
    # Rack::MiniProfiler.authorize_request if current_user.try(:admin)
  end

  def get_record(model, id, path)
    record = model.find(id) if model.exists?(id)
    if record && record.active
      record.update_column(:impressions_count, record.impressions_count+1)
      return record
    end
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
     :password_confirmation, :remember_me, :current_password, :avatar, :site]
  end
end
