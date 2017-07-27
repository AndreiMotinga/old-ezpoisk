require "rails_helper"

describe GeocodeJob do
  it "sets latitude, longitute and zip" do
    info = double(:info, lat: 1, lng: 2, zip: 11_223)
    listing = create(:listing, lat: 1, lng: 2, zip: 11_223)
    stub_geokit(listing, info)

    GeocodeJob.perform_async(listing.id, "Listing")
    GeocodeJob.drain
    listing.reload

    expect(listing.lat).to eq 1
    expect(listing.lng).to eq 2
    expect(listing.zip).to eq 11_223
  end

  def stub_geokit(listing, info)
    allow(Geokit::Geocoders::GoogleGeocoder)
      .to receive(:geocode)
      .with(listing.address)
      .and_return(info)
  end
end
