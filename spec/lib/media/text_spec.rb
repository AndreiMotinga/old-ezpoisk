require "rails_helper"

describe Media::Text do
  it "replaces &amp; with &" do
    text = "Foo &amp; bar"
    expect(Media::Text.clean(text)).to eq "Foo & bar"
  end

  it "handles emojis" do
    text = "🚗All types of rent cars🚕"
    expect(Media::Text.clean(text)).to eq "All types of rent cars"
  end

  # it "downcases text" do
  #   text = "SHOP $1,200 - Brooklyn, NY WALK IN COMMERCIAL SPACE FOR LEASE \
  #     E28 ST & AVE U. CALL OR TEXT LRE ALEX 718-809-3774"
  #   expected = "Shop $1,200 - brooklyn, ny walk in commercial space for lease \
  #     e28 st & ave u. Call or text lre alex 718-809-3774"
  #   expect(Media::Text.clean(text)).to eq expected
  # end
end
