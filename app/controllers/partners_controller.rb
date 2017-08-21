# frozen_string_literal: true

class PartnersController < DashboardController
  before_action :set_partner, only: [:edit, :update, :destroy, :duplicate]

  # GET /partners
  def index
    @partners = current_user.partners
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
    @partner = current_user.partners.build(partner_params)

    if @partner.save
      redirect_to edit_partner_path(@partner),
                  notice: 'Partner was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /partners/1
  def update
    if @partner.update(partner_params)
      redirect_to edit_partner_path(@partner),
                  notice: 'Partner was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /partners/1
  def destroy
    @partner.destroy
    redirect_to partners_path,
                notice: 'Partner was successfully destroyed.'
  end

  def duplicate
    @partner.dup.save
    redirect_to partners_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner
      @partner = current_user.partners.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def partner_params
      params.require(:partner).permit(:final_url, :title, :headline, :subline,
                                      :text, :image, :state_id, :city_id,
                                      tag_list: [])
    end
end
