class CitiesController < ApplicationController
  def index
    slug = params[:state_slug]
    if slug
      state = State.find_by_slug(slug)
      @cities = City.where(state_id: state.id).or(City.where(slug: City::ALL))
      @id = "slug"
    else
      state = State.find(params[:state_id])
      @cities = City.where(state_id: state.id).or(City.where(slug: City::ALL))
      @id = "id"
    end
  end
end
