class HackedMailer < ApplicationMailer
  def youve_been_owned(user)
    @user = user
    emails = User.where(admin: true).pluck(:email)
    emails << "ez@ezpoisk.com"
    mail(to: emails.join(","), subject: "YOU'VE BEEN FUCKED !!!   ezpoisk is hacked")
  end
end
