class Dashboard::PartnersController < ApplicationController
  layout 'partner'
  before_action :authenticate_user!
  before_action :set_ad, only: [:edit, :update, :destroy]

  def index
    @partners = current_user.partners.order("created_at")
  end

  def new
    @partner = Partner.new(phone: current_user.phone,
                           email: current_user.email)
  end

  def create
    @partner = current_user.partners.build(ad_params)

    if @partner.save
      SlackNotifierJob.perform_async(@partner.id, "Partner")
      redirect_to dashboard_partners_path, notice: I18n.t(:we_contact_shortly)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def edit
  end

  def update
    @partner.approved = false
    if @partner.update(ad_params)
      SlackNotifierJob.perform_async(@partner.id, "Partner", "Update")
      redirect_to dashboard_partners_path, notice: I18n.t(:we_contact_shortly)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @partner.destroy
    redirect_to dashboard_partners_path, notice: I18n.t(:post_removed)
  end

  def increment
    PartnerImpressionsJob.perform_async(params[:id])
  end

  def redirect
    partner = Partner.find(params[:id])
    partner.update_column(:clicks, partner.clicks + 1)
    redirect_to partner.redirect_url
  end

  private

  def set_ad
    @partner = current_user.partners.find(params[:id])
  end

  def ad_params
    params.require(:partner).permit(:title, :image, :url, :text,
                                    :position, :budget, :phone, :email)
  end
end
