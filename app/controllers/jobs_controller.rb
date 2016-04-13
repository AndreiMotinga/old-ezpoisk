class JobsController < ApplicationController
  # before_action :set_partners
  before_action :set_questions, only: :index

  def index
    @jobs = Job.filter(params.slice(:state_id,
                                    :city_id,
                                    :category,
                                    :geo_scope)).page(params[:page])
  end

  def show
    @job = get_record(Job, params[:id], jobs_path)
  end

  def set_questions
    @side_questions = Question.tagged_with("работа").limit(10)
  end

  def set_partners
    @partner_ads = PartnerAds.new("Работа", session)
  end
end
