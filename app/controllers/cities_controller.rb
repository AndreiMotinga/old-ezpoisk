class CitiesController < ApplicationController
  def update_cities
    @cities = State.find(params[:state_id]).cities
    @id = params[:id]
  end
end
