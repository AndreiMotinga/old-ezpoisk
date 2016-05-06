class Dashboard::PartnersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ad, only: [:show, :edit, :destroy]

  def index
    @partners = current_user.partners.order("created_at")
    @partners = @partners.page(params[:page])
  end

  def new
    @partner = Partner.new
  end

  def show
  end

  def edit
  end

  def create
    @partner = current_user.partners.build(ad_params)

    if @partner.save
      redirect_to dashboard_partners_path, notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def destroy
    @partner.destroy
    redirect_to dashboard_partners_path, notice: I18n.t(:post_removed)
  end

  private

  def set_ad
    @partner = current_user.partners.find(params[:id])
  end

  def ad_params
    params.require(:partner).permit(:title, :image, :link, :position, :page)
  end
end
