class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search, :show]
  before_action :set_listing, only: [:edit, :update, :destroy]
  layout "answers"

  def index
    @listings = Listing.includes(:state, :city)
                       .filter(sliced_params)
                       .page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @listings }
      end
    end
  end

  def show
    @listing = Listing.includes(:state, :city).find(params[:id])
    unless @listing && @listing.active?
      redirect_to root_path, alert: I18n.t(:post_not_found)
    end
  end

  def new
    @listing = Listing.new(state_id: current_user.state_id,
                           city_id: current_user.city_id,
                           active: true,
                           phone: current_user.phone,
                           email: current_user.email)
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      @listing.clear_phone!
      run_create_notifications
      redirect_to edit_listing_path(@listing), notice: I18n.t(:post_created)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def edit
  end

  def update
    address_changed = address_changed?(@listing, listing_params)
    if @listing.update(listing_params)
      @listing.clear_phone!
      GeocodeJob.perform_async(@listing.id, "Listing") if address_changed
      run_update_notifications
      redirect_to edit_listing_path(@listing),
                  notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @id = @listing.id
    @listing.destroy
    redirect_to listings_profile_path(current_user),
                notice: I18n.t(:post_removed)
  end

  private

  def listing_params
    params.require(:listing).permit(
      :kind, :category, :subcategory, :title, :text, :active,
      :state_id, :city_id, :street,
      :phone, :email, :vk, :fb, :gl, :tw, :ok, :site,
      :duration, :price, :baths, :space, :rooms
    )
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
    else
      @listing = current_user.listings.find(params[:id])
    end
  end
end
