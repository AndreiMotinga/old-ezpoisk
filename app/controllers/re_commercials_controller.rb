class ReCommercialsController < ApplicationController
  # before_action :set_partners, only: :index

  def index
    @re_commercials = ReCommercial.includes(:state, :city)
                                  .filter(sliced_params)
                                  .page(params[:page])
  end

  def show
    @re_commercial = get_record(ReCommercial, params[:id], re_commercials_path)
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Коммерческая")
  end

  def sliced_params
    params.slice(:state_id, :city_id, :geo_scope, :post_type, :space,
                 :min_price, :max_price, :sorted)
  end
end
