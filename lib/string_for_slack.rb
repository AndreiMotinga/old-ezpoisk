class StringForSlack
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
    string = "Новый отзыв\n"
    string += "name: #{record.name}\n" if record.name
    string += "email: #{record.email}\n" if record.email
    string += "text: #{record.body}\n"
    string
  end

  def user_string(user)
    string = "Регистрация нового пользователя\n"
    string += "id     #{user.id}\n"
    string += "name   #{user.name}\n email  #{user.email}\n"
    string += "phone  #{user.phone}\n"
    string += "\n"
    string += "Всего: #{User.count}"
    string += "==========================================================="
    string
  end

  def post_string(record)
    string = "Регистрация нового  #{record.class.to_s}\n"
    string += "id         #{record.id}\n"
    string += "title     #{record.title}\n" if record.try(:title)
    string += "category   #{record.category}\n" if record.try(:category)
    string += "\n"
    string += "Всего: #{record.class.count}"
    string += "==========================================================="
    string
  end
end
