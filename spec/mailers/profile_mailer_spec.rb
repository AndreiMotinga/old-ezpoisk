require "rails_helper"

describe ProfileMailer do
  describe "ten_visitors" do
    it "delivers email when user profile was views 10 times" do
      user = create(:user)
      ProfileMailer.ten_visitors(user).deliver_now

      delivery = deliveries.first

      expect(deliveries.count).to eq 1
      expect(delivery.to).to eq [user.email]
      expect(delivery.from).to eq ["ez@ezpoisk.com"]
      expect(delivery.subject).to eq "Наши поздравления - EZPOISK"
    end
  end

  describe "thanked" do
    it "delivers email when user was thanked" do
      user = create(:user)
      author = build(:user)
      ProfileMailer.thanked(user, author).deliver_now

      delivery = deliveries.first

      expect(deliveries.count).to eq 1
      expect(delivery.to).to eq [user.email]
      expect(delivery.from).to eq ["ez@ezpoisk.com"]
      expect(delivery.subject).to eq "Хэй, Вас поблагодарили - ezpoisk"
    end
  end
end
