class ServicesController < ApplicationController
  def index
    Service.connection.execute "SELECT setseed(#{rand_cookie})"
    services = Service.includes(:state, :city)
                      .filter(params.slice(:state_id,
                                           :city_id,
                                           :category,
                                           :subcategory,
                                           :geo_scope))
                      .order("RANDOM ()")
    @services = services.page(params[:page])
  end

  def show
    @service = get_record Service,
                          params[:id],
                          services_path
  end
end
