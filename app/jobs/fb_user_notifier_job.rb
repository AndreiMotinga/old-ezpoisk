# enqueues fb user notfier job
class FbUserNotifierJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(id, model)
    return if Rails.env.development?
    @record = model.constantize.find_by_id(id)
    return if !@record || !@record.try(:active) || !@record.fb.present?
    FbUserNotifier.new(@record).notify
  end
end
