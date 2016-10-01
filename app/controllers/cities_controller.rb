class CitiesController < ApplicationController
  def index
    @cities = State.find_by_slug(params[:state_slug]).cities if params[:state_slug]
    @cities = State.find(params[:state_id]).cities if params[:state_id]
  end
end
