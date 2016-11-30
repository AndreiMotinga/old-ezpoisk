class Dashboard::ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :set_listing, only: [:edit, :update, :destroy]

  def index
    @listings = current_user.listings
                            .order("updated_at desc")
                            .page(params[:page])
                            .per(25)
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @listings }
      end
    end
  end

  def new
    @listing = Listing.new(state_id: current_user.try(:state_id),
                           city_id: current_user.try(:city_id),
                           active: true,
                           phone: current_user.try(:new_phone),
                           email: current_user.try(:new_email))
  end

  def edit
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      @listing.clear_phone!
      run_create_notifications
      redirect_on_create
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    address_changed = address_changed?(@listing, listing_params)
    if @listing.update(listing_params)
      @listing.clear_phone!
      GeocodeJob.perform_async(@listing.id, "Listing") if address_changed
      run_update_notifications
      redirect_to update_redirect_path, notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @id = @listing.id
    @listing.destroy
    respond_to do |format|
      format.html do
        redirect_to destroy_redirect_path, notice: I18n.t(:post_removed)
      end
      format.js
    end
  end

  private

  def redirect_on_create
    if @listing.user
      redirect_to(
        edit_dashboard_listing_path(@listing),
        notice: I18n.t(:post_created)
      )
    else
      redirect_to(
        edit_dashboard_job_path(@listing, token: @listing.token),
        notice: I18n.t(:post_created_wr)
      )
    end
  end

  def update_redirect_path
    if params[:token].present?
      edit_dashboard_listing_path(@listing, token: params[:token])
    else
      edit_dashboard_listing_path(@listing)
    end
  end

  def run_update_notifications
    return if current_user.try(:team_member?)
    SlackNotifierJob.perform_async(@listing.id, "Listing", "update")
  end

  def run_create_notifications
    SlackNotifierJob.perform_async(@listing.id, "Listing")
    GeocodeJob.perform_async(@listing.id, "Listing")
  end

  def set_listing
    if current_user.try(:admin?)
      @listing = Listing.includes(:state, :city).find(params[:id])
    elsif params[:token].present?
      # todo why not just look by token?
      @listing = Listing.find(params[:id])
      @listing = nil unless @listing.token == params[:token]
    else
      @listing = current_user.listings.find(params[:id])
    end
  end

  def listing_params
    params.require(:listing).permit(
      :kind, :category, :subcategory, :title, :text, :active,
      :state_id, :city_id, :street,
      :phone, :email, :vk, :fb, :gl, :tw, :ok, :site,
      :duration, :price, :baths, :space, :rooms, :fee
    )
  end

  def destroy_redirect_path
    params[:token].present? ? root_path : dashboard_listings_path
  end
end
