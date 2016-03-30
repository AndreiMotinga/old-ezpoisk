class GeolocateUserJob
  include Sidekiq::Worker

  def perform(id)
    user = User.find(id)
    user.state_id = session[:state_id]
    user.city_id = session[:city_id]
    user.save
  end
end
