class Dash::ImportsController < ApplicationController
  def index
    @listings = Listing.inactive.includes(:state, :city)
    @listings = @listings.where(kind: params[:kind]) if params[:kind]
    @listings = @listings.page(params[:page])
  end
end
