# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "ez@ezpoisk.com"
  layout 'mailer'
end
