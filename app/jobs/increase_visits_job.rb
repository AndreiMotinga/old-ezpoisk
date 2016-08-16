class IncreaseVisitsJob
  include Sidekiq::Worker

  def perform(id, model)
    record = model.constantize.find(id)
    record.update_column(:visits, record.visits + 1)
  end
end
