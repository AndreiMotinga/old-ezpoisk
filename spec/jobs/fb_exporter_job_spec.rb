require "rails_helper"

describe FbExporterJob do
  it "posts to facebook" do
    listing = create(:listing)
    allow(Fb::Exporter).to receive(:post).with(listing)

    FbExporterJob.perform_async(listing.id, "Listing")
    FbExporterJob.drain

    expect(Fb::Exporter).to have_received(:post).with(listing)
  end
end
