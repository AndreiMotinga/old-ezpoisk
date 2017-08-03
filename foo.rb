# TASK
# // add to csv loading file
# 1. create these cities
florida = State.find_by_name("Florida")
City.create(state_id: florida.id, name: "Aventura", slug: "aventura", state_slug: "florida")
City.create(state_id: florida.id, name: "Sunny Isles Beach", slug: "sunny-isles-beach", state_slug: "florida")

State.find_each do |state|
  if ST.keys.map(&:to_s).include?(state.name)
    allowed = ST[state.name.to_sym]
    cities_to_remove = state.cities.where.not(name: allowed)
    Listing.where(city_id: cities_to_remove.pluck(:id)).map(&:destroy)
    cities_to_remove.delete_all
  else
    ids = state.cities.pluck :id
    Listing.where(state_id: state.id).map(&:destroy)
    Listing.where(city_id: ids).map(&:destroy)
    City.where(id: ids).map(&:destroy)
    state.destroy
  end
end
