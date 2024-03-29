# frozen_string_literal: true

# perfroms geolocation
# updates latitude, longitute and zipcode on listings
class GeocodeJob
  include Sidekiq::Worker

  # todo remove model - user listing
  def perform(id, model)
    return if Rails.env.development?
    @post = model.constantize.find_by_id(id)
    return unless @post && @post.street.present?
    @info = Geokit::Geocoders::GoogleGeocoder.geocode(@post.address)
    @post.update_attributes(info_hash)
  end

  private

  def info_hash
    {
      lat: @info.lat,
      lng: @info.lng,
      zip: @info.zip
    }
  end
end
