class ServicesController < ApplicationController
  def index
    @services = Service.filter(params.slice(
      :state_id, :city_id, :category, :subcategory, :geo_scope)).
      order("updated_at desc").
      page(params[:page])
  end

  def show
    @service = get_record(Service, params[:id], services_path)
  end
end
