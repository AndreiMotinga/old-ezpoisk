class CitiesController < ApplicationController
  def update_cities
    @cities = State.find(params[:state_id]).cities
  end
end
