class AdminPreview < ActionMailer::Preview
  def welcome
    return if Rails.env.production?
    AdminMailer.notify_about(ReAgency.last)
  end
end
