# frozen_string_literal: true

#exports listings to social media
class ListingExporterJob
  include Sidekiq::Worker

  def perform(id)
    return unless Rails.env.production?
    record = Listing.active.find_by_id(id)
    return unless record
    Vk::Exporter.export(record) unless record.vk?
    Fb::Exporter.export(record) unless record.fb?
  end
end
