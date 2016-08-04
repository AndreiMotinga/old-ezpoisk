class JobsController < ApplicationController
  # before_action :set_partners, only: :index

  def index
    @jobs = Job.includes(:state, :city)
               .filter(sliced_params)
               .page(params[:page])
  end

  def show
    @job = get_record(Job, params[:id], jobs_path)
    if @job.try(:active?)
      @new_comment = Comment.build_from(@job, current_user.try(:id )|| 4, "")
    end
  end

  private

  def sliced_params
    params.slice(:state_id, :city_id, :keyword, :category, :subcategory, :geo_scope)
  end

  def set_partners
    @partner_ads = PartnerAds.new("Работа")
  end
end
