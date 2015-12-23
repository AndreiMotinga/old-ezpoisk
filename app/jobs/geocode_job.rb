# perfroms geolocation
class GeocodeJob
  include Sidekiq::Worker

  def perform(id, model)
    @post = model.constantize.find(id)
    update_post info
  end

  private

  def info
    Geokit::Geocoders::GoogleGeocoder.geocode @post.address
  end

  def update_post(info)
    @post.latitude = info.lat
    @post.longitude = info.lng
    @post.zip = info.zip.to_i
    @post.save
  end
end
