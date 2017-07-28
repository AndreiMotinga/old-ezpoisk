class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search, :show]
  before_action :set_listing, only: [:edit, :update, :destroy]
  before_action :check_search, only: :index
  skip_before_action :authenticate_user!, only: [:edit, :update, :destroy], if: -> { params[:token].present? }
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

  def search
    @listings = Listing.includes(:state, :city)
                       .filter(sliced_params)
                       .page(params[:page])
    respond_to do |format|
      format.html { render :index }
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
      redirect_to after_udpate_path, notice: I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to root_path, notice: I18n.t(:post_removed)
  end

  private

  def after_udpate_path
    return edit_listing_path(@listing, token: params[:token]) if params[:token].present?
    edit_listing_path(@listing)
  end

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

  def set_listing
    if current_user.try(:admin?)
      @listing = Listing.find(params[:id])
    elsif params[:token]
      @listing = Listing.find_by_token(params[:token])
    else
      @listing = current_user.listings.find(params[:id])
    end
  end

  def check_search
    if [params[:kind], params[:category], params[:subcategory]].all?(&:present?)
      prms = request.parameters
                    .reject { |key| %w(controller action).include? key }
                    .reject { | _ , val| val.blank? }
                    .symbolize_keys
      redirect_to search_listings_path(prms)
    end
  end
end
