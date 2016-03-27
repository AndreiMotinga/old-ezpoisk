class Ezjob::JobsController < ApplicationController
  before_action :set_questions, only: :index

  def index
    @jobs = Job.filter(params.slice(:state_id,
                                    :city_id,
                                    :post_type,
                                    :category,
                                    :geo_scope)).page(params[:page])
  end

  def show
    @job = get_record(Job, params[:id], ezjob_jobs_path)
    impressionist(@job, nil, unique: [:session_hash]) if @job.try(:active)
  end

  def set_questions
    @side_questions = Question.tagged_with("работа").limit(10)
  end
end
