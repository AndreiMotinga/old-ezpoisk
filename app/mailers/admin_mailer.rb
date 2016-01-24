class AdminMailer < ApplicationMailer
  def notify_about(record)
    @record = record
    mail(to: "ez@ezpoisk.com", subject: "New #{@record.class}")
  end
end
