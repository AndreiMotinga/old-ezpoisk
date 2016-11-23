class Dashboard::PartnersController < ApplicationController
  before_action :authenticate_user!, except: [:increment, :show]
  before_action :set_ad, only: [:show, :edit, :update, :destroy]

  def index
    @partners = current_user.partners.order("created_at")
  end

  def new
    @partner = Partner.new(phone: current_user.phone,
                           email: current_user.email)
  end

  def show
    @partner.increment!(:clicks)
    begin
      redirect_to URI.parse(@partner.url).to_s
    rescue URI::InvalidURIError
      redirect_to root_path, alert: "Что-то пошло не так, проверьте url"
    end
  end

  def create
    @partner = current_user.partners.build(ad_params)
    @partner.approved = true if current_user.admin?
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
    @partner.approved = false unless current_user.admin?
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
    PartnerImpressionsJob.perform_async(params[:ids])
    render json: {}, status: 200
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
