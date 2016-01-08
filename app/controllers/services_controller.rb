class ServicesController < ApplicationController
  def index
    @services = Service.filter(params.slice(:state_id, :city_id))
    @services = geo_scope(@services) if geo_scoped_params?
    @total = @services.size
    @services = @services.page(params[:page])

    @services = @services.where(category: params[:category]) unless params[:category].blank?
    @services = @services.where(subcategory: params[:subcategory]) unless params[:subcategory].blank?
  end

  def show
    @service = Service.find(params[:id])
  end
end
