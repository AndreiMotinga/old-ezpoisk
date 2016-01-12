class ServicesController < ApplicationController
  def index
    services = Service.includes(:state, :city)
                      .filter(params.slice(:state_id,
                                           :city_id,
                                           :category,
                                           :subcategory,
                                           :geo_scope))
    @services = services.page(params[:page])
  end

  def show
    @service = get_record Service,
                          params[:id],
                          services_path
  end
end
