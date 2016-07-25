class SalesController < ApplicationController
  # before_action :set_partners

  def index
    @sales = Sale
             .includes(:state, :city)
             .filter(params.slice(:state_id,
                                  :city_id,
                                  :category,
                                  :keyword,
                                  :geo_scope))
             .order("updated_at desc")
             .page(params[:page])
  end

  def show
    @sale = get_record(Sale, params[:id], sales_path)
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new(params[:category])
  end
end
