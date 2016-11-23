class ListingsController < ApplicationController
  def index
    @listings = Listing.includes(:state, :city)
                       .where.not(id: favorites("Listing"))
                       .filter(sliced_params)
                       .page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @listings }
      end
    end
  end

  def search
    @listings = Listing.includes(:state, :city)
                       .filter(sliced_params)
                       .page(params[:page])
    # IncreaseImpressionsJob.perform_async(@jobs.pluck(:id), "Job")
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @listings } }
    end
  end

  def show
    @listing = Listing.includes(:state, :city, :pictures).find(params[:id])
    if @listing && @listing.active?
      IncreaseVisitsJob.perform_in(11.minutes, @listing.id, "Listing")
      if @listing.visits == 9
        ListingsNotifierJob.perform_in(12.minutes, @listing.id, "Listing")
      end
    else
      redirect_to root_path, alert: I18n.t(:post_not_found)
    end
  end

  def subcategories
    @subcategories = KINDS[:services][:subcategories][category]
  end

  private

  def category_param
    params.require(:attrs).permit(:category)
  end

  def category
    category_param[:category]
  end
end
