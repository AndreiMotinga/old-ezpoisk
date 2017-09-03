# frozen_string_literal: true

# exports articles to social media
class ArticleExporterJob
  include Sidekiq::Worker

  def perform(type, id)
    return unless Rails.env.production?
    record = type.constantize.find_by_id(id)
    return unless record
    Fb::Exporter.export(record)
    Vk::Exporter.export(record)
  end
end
