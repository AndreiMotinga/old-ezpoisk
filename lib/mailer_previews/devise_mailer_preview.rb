class Devise::MailerPreview < ActionMailer::Preview

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(User.last, "faketoken")
  end

  def password_change
    Devise::Mailer.password_change(User.last)
  end

  def unlock_instructions
    Devise::Mailer.unlock_instructions(User.last, "faketoken")
  end
end
