# frozen_string_literal: true

# TODO remove
# update importer services
class ServiceUpdateJob
  include Sidekiq::Worker
  sidekiq_options queue: "critical"

  def perform
    return unless Rails.env.production?
    Listing.where(done: false).first(1000) do |l|
      if l.lat.present? && l.lng.present?
        res = Geokit::Geocoders::GoogleGeocoder.reverse_geocode [l.lat, l.lng].join(",")
        state_id = State.find_by_abbr(res.state)&.id || State.create(abbr: res.state).id
        city_id = City.find_by_name(res.city)&.id || City.create(state_id: state_id, name: res.city).id

        l.update_columns(
          state_id: state_id,
          city_id: city_id,
          zip: res.zip,
          done: true
        )
      else
        l.update_columns(done: true)
      end
      return nil
    end
  end
end

Sidekiq::Cron::Job.create(name: "ServiceUpdateJob",
                          cron: "0 3 * * *",
                          class: "ServiceUpdateJob")
