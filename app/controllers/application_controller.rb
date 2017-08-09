class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_featured

  def set_featured
    @right, @left, @top  = Listing.featured.order("random ()").take(3)
  end

  protected

  def address_changed?(record, prms)
    return true if record.try(:street) != prms[:street]
    return true if record.state_id != prms[:state_id].to_i
    return true if record.city_id != prms[:city_id].to_i
  end

  def sliced_params
    prms = {}
    prms[:kind]        = params[:kind]        if params[:kind].present?
    prms[:subcategory] = params[:subcategory] if params[:subcategory].present?
    prms[:category]    = params[:category]    if params[:category].present?
    prms[:tag_list]    = params[:tag_list]    if params[:tag_list].present?
    prms[:term]        = params[:term]        if params[:term].present?
    prms[:min_price]   = params[:min_price]   if params[:min_price].present?
    prms[:max_price]   = params[:max_price]   if params[:max_price].present?
    prms[:duration]    = params[:duration]    if params[:duration].present?
    prms[:rooms]       = params[:rooms]       if params[:rooms].present?
    prms[:baths]       = params[:baths]       if params[:baths].present?
    prms[:sorted]      = params[:sorted]      if params[:sorted].present?
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
end
