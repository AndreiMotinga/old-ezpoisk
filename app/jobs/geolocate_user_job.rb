# get users state and city
class GeolocateUserJob
  include Sidekiq::Worker

  def perform(id)
    @user = User.find(id)
    update_user info
  end

  private

  def info
    Geokit::Geocoders::GoogleGeocoder.reverse_geocode "#{@user.lat},#{@user.lng}"
  end

  def update_user(info)
    state = State.find_by_name(info.state_name)
    city = state.cities.find_by_name(info.city)
    @user.state_id = state.id
    @user.city_id = city.id
    @user.save
  end
end
