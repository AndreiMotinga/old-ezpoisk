class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def geo_scope(records)
    records.within(params[:within],
                   origin: params[:origin])
  end

  def geo_scoped_params?
    !params[:within].blank? && !params[:origin].blank?
  end
end
