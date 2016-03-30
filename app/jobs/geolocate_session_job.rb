class GeolocateSessionJob
  include Sidekiq::Worker

  def perform(ip)
    data = Geokit::Geocoders::MultiGeocoder.geocode("67.80.0.147")
    state = State.find_by_abbr(data.state)
    city = state.cities.find_by_name(data.city)
    session[:state_id] = state.id
    session[:city_id] = city.id
  end
end
