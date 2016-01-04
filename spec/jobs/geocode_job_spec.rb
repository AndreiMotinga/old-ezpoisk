require "rails_helper"

describe GeocodeJob do
  it "sets latitude, longitute and zip" do
    # todo: makes external request. fix it
    re_private = create :re_private,
                        lat: nil,
                        lng: nil,
                        zip: nil

    subject.perform(re_private.id, "RePrivate")
    re_private.reload
    expect(re_private.lat).to_not be nil
    expect(re_private.lng).to_not be nil
    expect(re_private.zip).to_not be nil
  end
end
