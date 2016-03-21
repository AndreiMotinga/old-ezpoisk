class StringForSlack
  include Rails.application.routes.url_helpers
  attr_accessor :string

  def initialize(record)
    @string = string_from_record(record)
  end

  def string_from_record(record)
    case record.class.to_s
    when "User"
      string = user_string(record)
    when "Feedback"
      string = feedback_string(record)
    else
      string = post_string(record)
    end
    string
  end

  def feedback_string(record)
    string = "Новое сообщение\n"
    string += "id         #{record.id}\n"
    string += "name     #{record.name}\n"
    string += "email   #{record.email}\n"
    string += "phone   #{record.phone}\n"
    string += "message   #{record.message}\n"
    string += "\n"
    string += "Всего: #{record.class.count}\n"
    string += "==========================================================="
    string
  end

  def user_string(user)
    string = "Регистрация нового пользователя\n"
    string += "id     #{user.id}\n"
    string += "name   #{user.name}\n email  #{user.email}\n"
    string += "phone  #{user.phone}\n"
    string += "\n"
    string += "Всего: #{User.count}\n"
    string += "==========================================================="
    string
  end

  def post_string(record)
    string = "Регистрация нового  #{record.class.to_s}\n"
    string += "id         #{record.id}\n"
    string += "url        www.ezpoisk.com/#{link(record)}\n"
    string += "title     #{record.title}\n" if record.try(:title)
    string += "category   #{record.category}\n" if record.try(:category)
    string += "text   #{record.body}\n" if record.try(:body)
    string += "\n"
    string += "Всего: #{record.class.count}\n"
    string += "==========================================================="
    string
  end

  private

  def link(record)
    case record.class.to_s
    when "ReAgency"
      string = ezrealty_re_agency_path(record)
    when "ReFinance"
      string = ezrealty_re_finance_path(record)
    when "RePrivate"
      string = ezrealty_re_private_path(record)
    when "ReCommercial"
      string = ezrealty_re_commercial_path(record)
    when "JobAgency"
      string = ezjob_job_agency_path(record)
    when "Job"
      string = ezjob_job_path(record)
    when "Service"
      string = service_path(record)
    when "Sale"
      string = sale_path(record)
    when "Question"
      string = question_path(record)
    when "Answer"
      string = question_path(record.question)
    end
    string
  end
end
