require "rails_helper"

describe Media::Title do
  it "truncates to 66 chars" do
    text = "Some very long string of text here that should be truncated right about"
    result = "Some very long string of text here that should be truncated rig..."

    expect(Media::Title.of(text)).to eq result
  end
end
