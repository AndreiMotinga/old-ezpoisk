class Ezrealty::ReFinancesController < ApplicationController
  before_action :set_questions, only: :index

  def index
    @re_finances = ReFinance
      .filter(params.slice(:state_id, :city_id, :geo_scope))
      .page(params[:page])
  end

  def show
    @re_finance = get_record ReFinance, params[:id], ezrealty_re_finances_path
    impressionist(@re_finance, nil, unique: [:session_hash]) if @re_finance.try(:active)
  end

  private

  def set_questions
    @side_questions = Question.tagged_with("недвижимость").limit(10)
  end
end
