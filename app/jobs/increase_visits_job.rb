class IncreaseVisitsJob
  include Sidekiq::Worker

  # todo remove model - use listing
  def perform(id, model)
    record = model.constantize.find_by_id(id)
    return unless record
    record.increment!(:visits)
  end
end
