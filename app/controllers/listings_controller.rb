 # frozen_string_literal: true

class ListingsController < PagesController
  before_action :authenticate_user!, except: [:index, :search, :show]
  before_action :set_listing, only: [:edit, :update, :touch, :destroy]
  before_action :check_search, only: :index
  skip_before_action :authenticate_user!, only: [:edit, :update, :destroy], if: -> { params[:token].present? }
  after_action(only: [:index, :search]) { create_show_impressions(@listings) }
  after_action(only: :show) { create_visit_impression(@listing)  }
  after_action(only: [:create, :update]) { notify_slack(@listing, action_name) }

  def index
    @listings = Listing.includes(:state, :city)
                       .filter(sliced_params)
                       .page(params[:page])
    set_partners
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
    set_partners
    respond_to do |format|
      format.html { render :index }
      format.js do
        render partial: "shared/index", locals: { records: @listings }
      end
    end
  end

  def show
    @listing = Listing.includes(:state, :city).find(params[:id])
    set_show_partners
    @siblings = @listing.siblings.page(params[:page])
    create_show_impressions(@siblings)
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @siblings }
      end
    end
  end

  def new
    @listing = Listing.new(kind: params[:kind],
                           state_id: current_user.contact.state_id,
                           city_id: current_user.contact.city_id,
                           active: true,
                           phone: current_user.contact.phone,
                           email: current_user.email)
    @top = Partner.side(1)
  end

  def create
    @listing = current_user.listings.build(listing_params)
    if @listing.save
      GeocodeJob.perform_async(@listing.id, "Listing")
      @listing.clear_phone!
      redirect_to edit_listing_path(@listing), notice: I18n.t(:post_created)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def edit
    @top = Partner.side(1)
  end

  def update
    address_changed = address_changed?(@listing, listing_params)
    if @listing.update(listing_params)
      @listing.clear_phone!
      GeocodeJob.perform_async(@listing.id, "Listing") if address_changed
      flash.now[:notice] = I18n.t(:post_saved)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
    end
    render :edit
  end

  def touch
    @listing.touch
  end

  def destroy
    @id = @listing.id
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: I18n.t(:post_removed) }
      format.js
    end
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

  def set_listing
    if current_user.try(:admin?)
      @listing = Listing.find(params[:id])
    elsif params[:token].present?
      @listing = Listing.find_by_token(params[:token])
    else
      @listing = current_user.listings.find(params[:id])
    end
  end

  def check_search
    if [params[:kind], params[:category], params[:subcategory]].all?(&:present?)
      prms = request.parameters
                    .reject { |key| %w(controller action).include? key }
                    .reject { |_, val| val.blank? }
                    .symbolize_keys
      redirect_to search_listings_path(prms)
    end
  end

  def set_partners
    @top, @left, @right = Partner.side
    @inline = Partner.inline(3, PageKeywords.from_params(params))
  end

  def set_show_partners
    @top, @right = Partner.side(2)
    @inline = Partner.inline(1, @listing.page_keywords)
  end
end
