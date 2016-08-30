class ListingsMailer < ApplicationMailer
  def ten_visits(record)
    @record = record
    mail(to: record.contact_email, subject: "Процесс идет - EZPOISK")
  end
end
