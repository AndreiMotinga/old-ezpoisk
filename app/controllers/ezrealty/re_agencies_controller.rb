class Ezrealty::ReAgenciesController < ApplicationController
  before_action :set_patners

  def index
    @re_agencies = ReAgency
      .filter(params.slice(:state_id, :city_id, :geo_scope))
      .page(params[:page])
  end

  def show
    @re_agency = get_record(ReAgency, params[:id], ezrealty_re_agencies_path)
    impressionist @re_agency if @re_agency.try(:active)
  end

  private

  def set_patners
    @partner_ads = PartnerAds.new("Недвижимость", 1, nil, 1)
  end
end
