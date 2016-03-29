class Dashboard::PartnersController < ApplicationController
  layout "home"
  before_action :authenticate_user!
  before_action :set_ad, only: [:edit, :update, :destroy]
  before_action :set_partners, only: [:index, :new, :edit]

  def index
    @partners = current_user.partners.order("created_at")
  end

  def new
    @partner = Partner.new
  end

  def edit
  end

  def create
    @partner = current_user.partners.build(ad_params)

    if @partner.save
      SlackNotifierJob.perform_async(@partner.id, "Patner")
      AdminMailerJob.perform_async(@partner.id, "Patner")
      redirect_to dashboard_partners_path, notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @partner.update(ad_params)
      redirect_to dashboard_partners_path, notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  # def destroy
  #   @re_agency.destroy if @re_agency.user == current_user
  #   redirect_to dashboard_path,
  #               notice: I18n.t(:post_removed)
  # end

  private

  def set_ad
    @partner = current_user.partners.find(params[:id])
  end

  def ad_params
    params.require(:partner).permit(:title, :image, :link, :active, :bid,
                                    :budget, :position, page_ids:[])
  end

  def set_partners
    @partner_ads = PartnerAds.new("Панель Управления", 1, nil, nil)
  end
end
