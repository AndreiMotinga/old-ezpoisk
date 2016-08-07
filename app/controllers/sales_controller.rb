class SalesController < ApplicationController
  # before_action :set_partners

  def index
    @sales = Sale
             .includes(:state, :city)
             .filter(sliced_params)
             .page(params[:page])
    IncreaseImpressionsJob.perform_async(@sales.pluck(:id), "Sale")
  end

  def show
    @sale = get_record(Sale, params[:id], sales_path)
    if @sale.try(:active?)
      @new_comment = Comment.build_from(@sale, current_user.try(:id )|| 4, "")
    end
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new(params[:category])
  end

  def sliced_params
    params.slice(:state_id, :city_id, :category, :keyword, :sorted, :geo_scope)
  end
end
