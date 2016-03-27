class ServicesController < ApplicationController
  before_action :set_questions, only: :index

  def index
    @services = Service.filter(params.slice(
      :state_id, :city_id, :category, :subcategory, :geo_scope)).
      order("updated_at desc").
      page(params[:page])
  end

  def show
    @service = get_record(Service, params[:id], services_path)
    impressionist(@service, nil, unique: [:session_hash]) if @service.try(:active)
  end

  private

  def set_questions
    tags = [params[:category], params[:subcategory]]
    @side_questions = Question.tagged_with(tags, any: true).limit(10)
  end
end
