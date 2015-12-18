class CitiesController < ApplicationController
  def update_cities
    # TODO: wirte test for it
    @cities = State.find(params[:state_id]).cities
  end
end
