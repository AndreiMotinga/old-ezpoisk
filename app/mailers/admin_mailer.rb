class AdminMailer < ApplicationMailer
  def notify_about(record)
    @record = record
    mail(to: "andrew.motinga@gmail.com", subject: "New #{@record.class}")
  end
end
