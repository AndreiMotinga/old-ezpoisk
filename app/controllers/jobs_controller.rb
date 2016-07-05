class JobsController < ApplicationController
  # before_action :set_partners, only: :index

  def index
    @jobs = Job.filter(sliced_params).page(params[:page])
  end

  def show
    @job = get_record(Job, params[:id], jobs_path)
  end

  private

  def sliced_params
    params.slice(:state_id, :city_id, :category, :geo_scope)
  end

  def set_partners
    @partner_ads = PartnerAds.new("Работа")
  end

end
