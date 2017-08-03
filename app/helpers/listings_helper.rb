module ListingsHelper
  def search_states
    State.joins(:listings)
      .where(listings: { kind: params[:kind] })
      .distinct
      .order(:name)
      .map{|s| [s.name, s.slug]}
      .insert(0, ["Выберите штат", ""])
  end

  def state_cities
    return [] unless state
    City.where(state_slug: state)
      .or(City.where(slug: City::ALL))
      .joins(:listings)
      .where(listings: { kind: params[:kind] })
      .distinct
      .order(:name)
  end
end
