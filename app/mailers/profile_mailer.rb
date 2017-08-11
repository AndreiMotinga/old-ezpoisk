# frozen_string_literal: true

class ProfileMailer < ApplicationMailer
  def ten_visitors(user)
    @user = user
    mail(to: @user.email, subject: "Наши поздравления - EZPOISK")
  end

  def thanked(user, author)
    @user = user
    @author = author
    mail(to: @user.email, subject: "Хэй, Вас поблагодарили - ezpoisk")
  end
end
