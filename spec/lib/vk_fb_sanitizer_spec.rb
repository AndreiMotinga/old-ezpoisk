require "rails_helper"

describe Media::Sanitizer do
  it "replaces &amp; with &" do
    text = "foo &amp; bar"
    expect(Media::Sanitizer.clean(text)).to eq "foo & bar"
  end

  # it "handles sanitizer" do
  #   text = "🚗All types of rent cars🚕"
  #   expect(Media::Sanitizer.clean(text)).to eq "All types of rent cars"
  # end
end
