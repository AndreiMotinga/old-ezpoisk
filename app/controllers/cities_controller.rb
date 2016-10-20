class CitiesController < ApplicationController
  def index
    slug = params[:state_slug]
    id = params[:state_id]
    if slug.present?
      state = State.find_by_slug(slug)
      @cities = City.where(state_id: state.id).or(City.where(slug: City::ALL))
      @id = "slug"
    elsif id.present?
      state = State.find(params[:state_id])
      @cities = City.where(state_id: state.id).or(City.where(slug: City::ALL))
      @id = "id"
    else
      @cities = []
      @id = ""
    end
  end
end
