require "rails_helper"

describe SocialTextSanitizer do
  it "replaces &amp; with &" do
    text = "foo &amp; bar"
    expect(SocialTextSanitizer.clean(text)).to eq "foo & bar"
  end

  # it "handles sanitizer" do
  #   text = "🚗All types of rent cars🚕"
  #   expect(SocialTextSanitizer.clean(text)).to eq "All types of rent cars"
  # end
end

