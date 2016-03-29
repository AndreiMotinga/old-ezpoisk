class ServicesController < ApplicationController
  before_action :set_questions, only: :index

  def index
    @services = Service.filter(params.slice(
      :state_id, :city_id, :category, :subcategory, :geo_scope)).
      order("updated_at desc").
      page(params[:page])
    @partner_ads = PartnerAds.new("Недвижимость", 1, 1, 1)
  end

  def show
    @service = get_record(Service, params[:id], services_path)
    if @service.try(:active)
      impressionist(@service, nil, unique: [:session_hash])
      @partner_ads = PartnerAds.new("Недвижимость", 1, nil, nil)
    end
  end

  private

  def set_questions
    tags = [params[:category], params[:subcategory]]
    @side_questions = Question.tagged_with(tags, any: true).limit(10)
  end
end
