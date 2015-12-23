require "rails_helper"

describe GeocodeJob do
  it "sets latitude, longitute and zip" do
    re_private = create :re_private,
                        latitude: nil,
                        longitude: nil,
                        zip: nil

    subject.perform(re_private.id, "RePrivate")
    re_private.reload
    expect(re_private.latitude).to_not be nil
    expect(re_private.longitude).to_not be nil
    expect(re_private.zip).to_not be nil
  end
end
