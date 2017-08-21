# frozen_string_literal: true

class CitiesController < ApplicationController
  before_action :id, :slug, :set_val

  def index
    if params[:kind].present?
      @cities = cities.joins(:listings)
        .where(listings: { kind: params[:kind] })
        .distinct
        .order(:name)
    else
      @cities = cities.order(:name)
    end
  end

  private

  def set_val
    @val = :slug if slug.present?
    @val = :id if id.present?
  end

  def slug
    @slug ||= params[:state_slug]
  end

  def id
    @id ||= params[:state_id]
  end

  def state
    return State.find_by_slug(slug) if slug.present?
    return State.find(id) if id.present?
  end

  def cities
    City.where(state_id: state.id)
  end
end
