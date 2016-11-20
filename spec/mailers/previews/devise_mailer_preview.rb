class Devise::MailerPreview < ActionMailer::Preview
  def reset_password_instructions
    return if Rails.env.production?
    Devise::Mailer.reset_password_instructions(User.last, "faketoken")
  end

  def password_change
    return if Rails.env.production?
    Devise::Mailer.password_change(User.last)
  end

  def unlock_instructions
    return if Rails.env.production?
    Devise::Mailer.unlock_instructions(User.last, "faketoken")
  end
end
