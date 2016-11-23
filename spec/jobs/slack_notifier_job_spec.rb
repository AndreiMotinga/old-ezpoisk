require "rails_helper"

describe SlackNotifierJob do
  it "sends messsages to slack" do
    listing = build_stubbed(:listing)
    allow(Listing).to receive(:find_by_id).with(listing.id).and_return(listing)
    allow(Ez).to receive(:notify_about).with(listing, "new")

    SlackNotifierJob.perform_async(listing.id, listing.class.to_s)
    SlackNotifierJob.drain

    expect(Listing).to have_received(:find_by_id).with(listing.id)
    expect(Ez).to have_received(:notify_about).with(listing, "new")
  end
end
