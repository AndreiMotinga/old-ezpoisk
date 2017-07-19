class Dashboard::ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]
  before_action :set_listing, only: [:edit, :update, :destroy]

  def new
    @listing = Listing.new(state_id: current_user.state_id,
                           city_id: current_user.city_id,
                           active: true,
                           phone: current_user.phone,
                           email: current_user.email)
  end

  def edit
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      @listing.clear_phone!
      run_create_notifications
      redirect_to listing_path(@listing), notice: I18n.t(:post_created)
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
        redirect_to listings_profile_path(current_user),
                    notice: I18n.t(:post_removed)
      end
      format.js
    end
  end

  private

  def update_redirect_path
    if params[:token].present?
      edit_dashboard_listing_path(@listing, token: params[:token])
    else
      edit_dashboard_listing_path(@listing)
    end
  end

  def run_update_notifications
    return if current_user.try(:admin?)
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
      :duration, :price, :baths, :space, :rooms
    )
  end
end
