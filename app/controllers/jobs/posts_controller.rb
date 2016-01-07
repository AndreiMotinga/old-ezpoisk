class Jobs::PostsController < ApplicationController
  layout "jobs"

  def index
    if geo_scoped_params?
      @jobs = geo_scope(Job.all)
    else
      @jobs = Job.filter(params.slice(:state_id, :city_id))
    end
    @jobs = @jobs.where(category: params[:category]) unless params[:category].blank?
    @jobs = @jobs.where(subcategory: params[:subcategory]) unless params[:subcategory].blank?
    @total = @jobs.size
    @jobs = @jobs.page(params[:page])
  end

  def show
    @job = Job.find(params[:id])
  end
end
