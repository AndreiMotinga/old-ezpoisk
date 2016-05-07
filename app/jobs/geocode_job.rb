# perfroms geolocation
class GeocodeJob
  include Sidekiq::Worker

  def perform(id, model)
    return unless Rails.env.production?
    @post = model.constantize.find(id)
    update_post info
  end

  private

  def info
    Geokit::Geocoders::GoogleGeocoder.geocode @post.address
  end

  def update_post(info)
    @post.update_attribute(:lat, info.lat)
    @post.update_attribute(:lng, info.lng)
    @post.update_attribute(:zip, info.zip)
  end
end
