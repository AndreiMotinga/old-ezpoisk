class CitiesController < ApplicationController
  def update_cities
    state_id = params[:state_id]
    return @cities = State.find(state_id).cities if state_id.present?
    @cities = []
  end
end
