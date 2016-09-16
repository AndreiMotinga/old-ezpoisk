class ServicesController < ApplicationController
  def index
    @services = Service.includes(:state, :city)
                       .filter(sliced_params)
                       .page(params[:page])
    IncreaseImpressionsJob.perform_async(@services.pluck(:id), "Service")
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @services }
      end
    end
  end

  def show
    @service = get_record(Service, params[:id], services_path)
    @pictures = @service.pictures.page(params[:pictures_page]).per(20)
    @reviews = @service.reviews.includes(:user).page(params[:reviews_page])
    set_records
  end

  private

  def sliced_params
    params.slice(:state_id, :city_id, :category, :subcategory, :geo_scope)
  end

  def set_records
    if params[:pictures_page]
      @param = :pictures_page
      @records = @pictures
    elsif params[:reviews_page]
      @param = :reviews_page
      @records = @reviews
    end
  end
end
