class CitiesController < ApplicationController
  def update_cities
    if  params[:state_id].present?
      @cities = State.find(params[:state_id]).cities
    else
      @cities = []
    end
  end
end
