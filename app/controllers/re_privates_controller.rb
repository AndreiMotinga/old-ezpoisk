class RePrivatesController < ApplicationController
  # before_action :set_partners, only: :index

  def index
    @re_privates = RePrivate.filter(sliced_params).page(params[:page])
  end

  def show
    @re_private = get_record(RePrivate, params[:id], re_privates_path)
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new("Частная")
  end

  def sliced_params
    params.slice(:state_id, :city_id, :geo_scope, :fee, :duration, :post_type,
                 :space, :baths, :rooms, :min_price, :max_price, :sorted)
  end
end
