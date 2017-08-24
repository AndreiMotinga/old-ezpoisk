# frozen_string_literal: true

class PartnersController < ApplicationController
  before_action :set_partner, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /partners
  def index
    @partners = current_user.admin? ? Partner.all : current_user.partners
    @partners = @partners.where(user_id: params[:u_id]) if params[:u_id].present?
    sort_order = "#{params[:sort]} #{params[:order]}"
    @partners = @partners.includes(:state, :city).order(sort_order).page(params[:page])

    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @partners }
      end
    end
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
  end

  def duplicate
    @old = Partner.find(params[:id])
    @partner = Partner.create(title: @old.title,
                              final_url: @old.final_url,
                              headline: @old.headline,
                              subline: @old.subline,
                              text: @old.text,
                              state_id: @old.state_id,
                              city_id: @old.city_id,
                              user_id: @old.user_id,
                              tag_list: @old.tag_list,
                              image: @old.image)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner
      if current_user.admin?
        @partner = Partner.find(params[:id])
      else
        @partner = current_user.partners.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def partner_params
      params.require(:partner).permit(:final_url, :title, :headline, :subline,
                                      :text, :image, :state_id, :city_id,
                                      tag_list: [])
    end
end
