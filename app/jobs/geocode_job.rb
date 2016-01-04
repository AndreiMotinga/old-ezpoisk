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
    @post.lat= info.lat
    @post.lng= info.lng
    @post.zip = info.zip.to_i
    @post.save
  end
end
