class AdminPreview < ActionMailer::Preview
  def welcome
    AdminMailer.notify_about(ReAgency.last)
  end
end
