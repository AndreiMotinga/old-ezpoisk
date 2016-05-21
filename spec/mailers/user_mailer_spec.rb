require "rails_helper"

describe UserMailer do
  describe "welcome_email" do
    it "delivers welcome email to user" do
      user = build(:user)
      UserMailer.welcome_email(user).deliver_now

      delivery = deliveries.first

      expect(deliveries.count).to eq 1
      expect(delivery.to).to eq [user.email]
      expect(delivery.from).to eq ["ez@ezpoisk.com"]
      expect(delivery.subject).to eq "Добро пожаловать на EZPOISK"
    end
  end

  def deliveries
    ActionMailer::Base.deliveries
  end
end
