class SalesController < ApplicationController
  before_action :set_partners
  before_action :set_questions, only: :index

  def index
    sales = Sale.filter(params.slice(:state_id,
                                     :city_id,
                                     :category,
                                     :keyword,
                                     :geo_scope))
                .order("created_at desc")
    @sales = sales.page(params[:page])
  end

  def show
    @sale = get_record(Sale, params[:id], sales_path)
  end

  private

  def set_questions
    tags = ["шопинг", params[:category]]
    @side_questions = Question.tagged_with(tags, any: true).limit(10)
  end

  def set_partners
    @partner_ads = PartnerAds.new(params[:category])
  end
end
