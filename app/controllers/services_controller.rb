class ServicesController < ApplicationController
  def index
    redirect_to search_services_path(sliced_params) if search?
    @services = Service.includes(:state, :city)
                       .where.not(id: favorites("Service"))
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

  def search
    @services = Service.includes(:state, :city)
                       .filter(sliced_params)
                       .page(params[:page])
    IncreaseImpressionsJob.perform_async(@services.pluck(:id), "Service")
    respond_to do |format|
      format.html { render :index }
      format.js do
        render partial: "shared/index", locals: { records: @services }
      end
    end
  end

  def show
    @service = get_record(Service, params[:id], services_path)
    @pictures = @service.pictures.page(params[:pictures_page]).per(40)
    @reviews = @service.reviews.includes(:user).page(params[:reviews_page])
    set_records
  end

  private

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
