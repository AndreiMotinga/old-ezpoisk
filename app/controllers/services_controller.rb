class ServicesController < ApplicationController
  def all
  end

  def index
    @services = Service.includes(:state, :city)
                       .filter(sliced_params)
                       .page(params[:page])
    IncreaseImpressionsJob.perform_async(@services.pluck(:id), "Service")
  end

  def show
    @service = get_record(Service, params[:id], services_path)
  end

  private

  def sliced_params
    params.slice(:state_id, :city_id, :category, :subcategory, :geo_scope)
  end
end
