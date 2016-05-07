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
    when "Partner"
      string = partner_string(record)
    else
      string = post_string(record)
    end
    string
  end

  def partner_string(record)
    "Новый Банер
    id               #{record.id}
    title            #{record.title}
    user             #{record.user.email}
    amount           #{record.amount / 100}
    position         #{record.position}
    page             #{record.page}
    link             #{record.link}
    start_date       #{record.start_date}
    active_until     #{record.active_until}
    image            #{record.image.url}\n"
  end

  def feedback_string(record)
    "Новое сообщение
    id         #{record.id}
    name       #{record.name}
    email      #{record.email}
    phone      #{record.phone}
    message    #{record.message}
    Всего:     #{record.class.count}"
  end

  def user_string(user)
    "Регистрация нового пользователя
    id         #{user.id}
    name       #{user.profile_name}
    email      #{user.email}
    phone      #{user.profile_phone}
    Всего      #{User.count}"
  end

  def post_string(record)
    "Регистрация нового  #{record.class.to_s}
    author     #{record.try(:user).try(:email)}
    id         #{record.id}
    url        www.ezpoisk.com#{link(record)}
    title      #{record.try(:title)}
    category   #{record.try(:category)}
    text       #{record.try(:body)}
    Всего      #{record.class.count}"
  end

  private

  def link(record)
    case record.class.to_s
    when "RePrivate"
      re_private_path(record)
    when "ReCommercial"
      re_commercial_path(record)
    when "Job"
      job_path(record)
    when "Service"
      service_path(record)
    when "Sale"
      sale_path(record)
    when "Question"
      question_path(record)
    when "Answer"
      question_path(record.question)
    end
  end
end
