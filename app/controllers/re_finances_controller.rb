class ReFinancesController < ApplicationController
  before_action :set_questions, only: :index

  def index
    @re_finances = Service.re_finances.filter(
      params.slice(:state_id, :city_id, :geo_scope)
    ).order("updated_at desc").page(params[:page])
  end

  def show
    @re_finance = get_record(Service, params[:id], re_finances_path)
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("Недвижимость").limit(10)
  end
end
