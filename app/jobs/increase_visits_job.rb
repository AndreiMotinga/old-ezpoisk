class IncreaseVisitsJob
  include Sidekiq::Worker

  def perform(id, model)
    record = model.constantize.find_by_id(id)
    return unless record
    record.update_column(:visits, record.visits + 1)
  end
end
