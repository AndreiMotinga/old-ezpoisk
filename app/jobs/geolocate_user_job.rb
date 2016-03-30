# get users state and city
class GeolocateUserJob
  include Sidekiq::Worker

  def perform(ip)
    string = Geokit::Geocoders::MultiGeocoder.geocode(ip).to_s
    Ez.ping(string)
  end

  private

  # def update_user(info)
  #   state = State.find_by_name(info.state_name)
  #   city = state.cities.find_by_name(info.city)
  #   @user.state_id = state.id
  #   @user.city_id = city.id
  #   @user.save
  # end
end
