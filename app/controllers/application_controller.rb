class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_rack_mini_profiler

  private

  def check_rack_mini_profiler
    if current_user.try(:admin) || ENV["RACK_MINI_PROFILER"]
       Rack::MiniProfiler.authorize_request
    end
  end

  def get_record(model, id, path)
    item = model.cached_find(id)
    if item && item.active?
      IncreaseVisitsJob.perform_in(11.minutes, item.id, item.class.to_s)
      if item.visits == 9
        ListingsNotifierJob.perform_in(12.minutes, item.id, item.class.to_s)
      end
      return item
    end
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

  def search?
    return false if params[:geo_scope] && params[:geo_scope][:origin].present?
    return true if params[:state].present?
  end

  def sliced_params
    prms = {}
    prms[:subcategory] = params[:subcategory] if params[:subcategory].present?
    prms[:category]    = params[:category]    if params[:category].present?
    prms[:tag_list]    = params[:tag_list]    if params[:tag_list].present?
    prms[:keyword]     = params[:keyword]     if params[:keyword].present?
    prms[:post_type]   = params[:post_type]   if params[:post_type].present?
    prms[:min_price]   = params[:min_price]   if params[:min_price].present?
    prms[:max_price]   = params[:max_price]   if params[:max_price].present?
    prms[:duration]    = params[:duration]    if params[:duration].present?
    prms[:rooms]       = params[:rooms]       if params[:rooms].present?
    prms[:baths]       = params[:baths]       if params[:baths].present?
    prms[:sorted]      = params[:sorted]      if params[:sorted].present?
    prms[:fee]         = params[:fee]         if params[:fee].present?
    if params[:geo_scope] && params[:geo_scope][:origin].present?
      prms[:geo_scope] = {}
      prms[:geo_scope][:origin] = params[:geo_scope][:origin]
      prms[:geo_scope][:within] = params[:geo_scope][:within]
    else
      prms[:state] = params[:state] if params[:state].present?
      prms[:city]  = params[:city]  if params[:city].present?
    end
    prms
  end

  def favorites(type)
    return [] unless current_user
    current_user.favorites.where(favorable_type: type).pluck(:favorable_id)
  end
end
