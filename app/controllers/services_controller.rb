class ServicesController < ApplicationController
  # before_action :set_partners

  def all
  end

  def index
    @services = Service.filter(sliced_params)
                       .order("updated_at desc")
                       .page(params[:page])
  end

  def show
    @service = get_record(Service, params[:id], services_path)
  end

  private

  def set_partners
    @partner_ads = PartnerAds.new(params[:subcategory])
  end

  def sliced_params
    params.slice(:state_id, :city_id, :category, :subcategory, :geo_scope)
  end
end
