# frozen_string_literal: true

class PartnersController < DashboardController
  before_action :set_campaign
  before_action :set_partner, only: [:edit, :update, :destroy, :duplicate]

  # GET /partners
  def index
    @partners = @campaign.partners
  end

  # GET /partners/new
  def new
    @partner = Partner.new
  end

  # GET /partners/1/edit
  def edit
  end

  # POST /partners
  def create
    @partner = @campaign.partners.build(partner_params)

    if @partner.save
      redirect_to edit_campaign_partner_path(@campaign, @partner),
                  notice: 'Partner was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /partners/1
  def update
    if @partner.update(partner_params)
      redirect_to edit_campaign_partner_path(@campaign, @partner),
                  notice: 'Partner was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /partners/1
  def destroy
    @partner.destroy
    redirect_to campaign_partners_path(@campaign),
                notice: 'Partner was successfully destroyed.'
  end

  def duplicate
    @partner.dup.save
    redirect_to campaign_partners_path(@campaign)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner
      @partner = @campaign.partners.find(params[:id])
    end

    def set_campaign
      @campaign = current_user.campaigns.find(params[:campaign_id])
    end

    # Only allow a trusted parameter "white list" through.
    def partner_params
      params.require(:partner).permit(:final_url, :title, :headline,
                                      :description, :image)
    end
end
