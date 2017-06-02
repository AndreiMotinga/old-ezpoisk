class ListingsController < ApplicationController
  def index
    @listings = Listing.includes(:state, :city)
                       .order("featured, priority desc, updated_at desc")
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
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @listings } }
    end
  end

  def show
    @listing = Listing.includes(:state, :city).find(params[:id])
    unless @listing && @listing.active?
      redirect_to root_path, alert: I18n.t(:post_not_found)
    end
  end
end
