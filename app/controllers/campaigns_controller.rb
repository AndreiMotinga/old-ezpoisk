# frozen_string_literal: true

class CampaignsController < DashboardController
  before_action :set_campaign, only: [:edit, :update, :destroy]

  # GET /campaigns
  def index
    @campaigns = current_user.campaigns.includes(:state, :city)
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  def create
    @campaign = current_user.campaigns.build(campaign_params)

    if @campaign.save
      redirect_to campaign_partners_path(@campaign),
                  notice: 'Campaign was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /campaigns/1
  def update
    if current_user.campaigns.update(campaign_params)
      redirect_to campaigns_path, notice: 'Campaign was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /campaigns/1
  def destroy
    @campaign.destroy
    redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = current_user.campaigns.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def campaign_params
      params.require(:campaign).permit(:title, :bid, :budget, :state_id, :city_id)
    end
end
