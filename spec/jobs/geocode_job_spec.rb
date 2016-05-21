require "rails_helper"

describe GeocodeJob do
  it "sets latitude, longitute and zip" do
    info = double(:info, lat: 1, lng: 2, zip: 11_223)
    re_private = create(:re_private)
    stub_geokit(re_private, info)

    GeocodeJob.perform_async(re_private.id, "RePrivate")
    GeocodeJob.drain
    re_private.reload

    expect(re_private.lat).to eq 1
    expect(re_private.lng).to eq 2
    expect(re_private.zip).to eq 11_223
  end

  def stub_geokit(re_private, info)
    allow(Geokit::Geocoders::GoogleGeocoder)
      .to receive(:geocode)
      .with(re_private.address)
      .and_return(info)
  end
end
