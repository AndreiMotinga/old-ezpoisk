require "rails_helper"

describe ProfileMailer do
  describe "welcome_email" do
    it "delivers welcome email to user" do
      user = build(:user)
      ProfileMailer.ten_visitors(user).deliver_now

      delivery = deliveries.first

      expect(deliveries.count).to eq 1
      expect(delivery.to).to eq [user.email]
      expect(delivery.from).to eq ["ez@ezpoisk.com"]
      expect(delivery.subject).to eq "Наши поздравления - EZPOISK"
    end
  end
end
