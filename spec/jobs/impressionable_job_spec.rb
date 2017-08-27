require "rails_helper"

describe ImpressionableJob do
  it "creates impression" do
    listing = create :listing
    user = create_and_login_user

    ImpressionableJob.perform_async("Listing",
                                    listing.id,
                                    "showed",
                                    user.id,
                                    "127.0.0.1",
                                    "ezpoisk.com")
    ImpressionableJob.drain

    expect(Impression.count).to eq 1
    impression = Impression.first
    expect(impression.impressionable_type).to eq "Listing"
    expect(impression.impressionable_id).to eq listing.id
    expect(impression.kind).to eq "showed"
    expect(impression.user_id).to eq user.id
    expect(impression.ip_address).to eq "127.0.0.1"
    expect(impression.referrer).to eq "ezpoisk.com"
  end
end
