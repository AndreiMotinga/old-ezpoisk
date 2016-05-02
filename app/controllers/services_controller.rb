class ServicesController < ApplicationController
  before_action :set_questions, only: :index
  before_action :set_partners

  def all
  end

  def index
    @services = Service.filter(params.slice(
      :state_id, :city_id, :category, :subcategory, :geo_scope)).
      order("updated_at desc").
      page(params[:page])
  end

  def show
    @service = get_record(Service, params[:id], services_path)
  end

  private

  def set_questions
    tags = [params[:category], params[:subcategory]]
    @side_questions = Question.tagged_with(tags, any: true).limit(10)
  end

  def set_partners
    state_id = session[:state_id]
    return if state_id == 0
    @partner_ads = PartnerAds.new(state_id, params[:subcategory])
  end
end
