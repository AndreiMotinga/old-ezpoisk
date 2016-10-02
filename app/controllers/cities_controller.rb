class CitiesController < ApplicationController
  def index
    slug = params[:state_slug]
    if slug
      @cities = State.find_by_slug(slug).cities
      @id = "slug"
    else
      @cities = State.find(params[:state_id]).cities
      @id = "id"
    end
  end
end
