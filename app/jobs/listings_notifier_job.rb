# sends email when listing was visited 10 times
class ListingsNotifierJob
  include Sidekiq::Worker

  def perform(id, model)
    # return if Rails.env.development?
    record = model.constantize.find(id)
    return unless record.contact_email
    return if record.user.try(:id) == 181 # ez
    ListingsMailer.ten_visits(record).deliver_now
  end
end
