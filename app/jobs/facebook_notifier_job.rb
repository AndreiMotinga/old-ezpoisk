# notifies facebook pages of new listings
class FacebookNotifierJob
  include Sidekiq::Worker

  def perform(id, model)
    return if Rails.env.development?
    record = model.constantize.find_by_id(id)
    return unless record
    FacebookNotifier.post(record)
  end
end
