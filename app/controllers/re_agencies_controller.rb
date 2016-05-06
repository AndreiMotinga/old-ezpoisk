class ReAgenciesController < ApplicationController
  before_action :set_partners, only: :index
  before_action :set_questions, only: :index

  def index
    @re_agencies = Service.re_agencies.filter(
      params.slice(:state_id, :city_id, :geo_scope)
    ).order("updated_at desc").page(params[:page])
  end

  def show
    @re_agency = get_record(Service, params[:id], re_agencies_path)
  end

  private

  def set_questions
    @questions = Question.tagged_with("недвижимость").limit(10)
  end

  def set_partners
    @partner_ads = PartnerAds.new("Агентства Недвижимости")
  end
end
