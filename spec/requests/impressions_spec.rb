require "rails_helper"

describe "Impressions" do
  describe "GET #show" do
    it "schedules job to create visit impression" do
      partner = create :partner
      allow(ImpressionableJob)
        .to receive(:perform_in)
        .with(1.minute,
              "Partner",
              partner.id.to_s,
              "visit",
              nil,
              "127.0.0.1",
              nil)

      get impression_path(id: partner.id, final_url: partner.final_url)
      expect(ImpressionableJob)
        .to have_received(:perform_in)
        .with(1.minute,
              "Partner",
              partner.id.to_s,
              "visit",
              nil,
              "127.0.0.1",
              nil)
    end

    it "redirects proper url" do
      partner = create :partner
      get impression_path(id: partner.id, final_url: partner.final_url)
      expect(response).to redirect_to(partner.final_url)
    end
  end

  describe "POST #create" do
    it "schedules job to create show impression" do
      partner = create :partner
      allow(ImpressionableJob)
        .to receive(:perform_in)
        .with(1.minute,
              "Partner",
              partner.id.to_s,
              "show",
              nil,
              "127.0.0.1",
              nil)

      post impressions_path(id: partner)

      expect(ImpressionableJob)
        .to have_received(:perform_in)
        .with(1.minute,
              "Partner",
              partner.id.to_s,
              "show",
              nil,
              "127.0.0.1",
              nil)
    end
  end
end
