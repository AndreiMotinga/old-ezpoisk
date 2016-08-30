class ProfileMailer < ApplicationMailer
  def ten_visitors(user)
    @user = user
    mail(to: @user.email, subject: "Наши поздравления - EZPOISK")
  end
end
