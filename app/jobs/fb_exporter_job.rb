# notifies facebook pages of new listings
class FbExporterJob
  include Sidekiq::Worker

  def perform(id, model)
    return if Rails.env.development?
    record = model.constantize.find_by_id(id)
    return unless record
    Fb::Exporter.post(record)
  end
end
