class Dash::ImportsController < ApplicationController
  def index
    @listings = Listing.unapproved.includes(:state, :city)
    @listings = @listings.where(kind: params[:kind]) if params[:kind]
    order = "case when done is null then -1 else 1 end desc"
    @listings = @listings.order(order).page(params[:page]).per(50)
  end
end
