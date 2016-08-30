require "rails_helper"

describe ListingsMailer do
  describe "ten_visits" do
    it "delivers email when user profile was views 10 times" do
      rp = create(:re_private)
      ListingsMailer.ten_visits(rp).deliver_now

      delivery = deliveries.first

      expect(deliveries.count).to eq 1
      expect(delivery.to).to eq [rp.contact_email]
      expect(delivery.from).to eq ["ez@ezpoisk.com"]
      expect(delivery.subject).to eq "Процесс идет - EZPOISK"
    end
  end
end
