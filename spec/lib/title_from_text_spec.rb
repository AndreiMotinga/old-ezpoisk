require "rails_helper"

describe Media::Title do
  context "downcasing" do
    it "downcases and capitalizes title" do
      text = "КАК ЭТО СДЕЛАТЬ"
      expect(Media::Title.get(text)).to_not eq "Как это сделать..."
    end

    it "downcases and capitalizes title" do
      text = "NOW HIRING"
      expect(Media::Title.get(text)).to_not eq "Now hiring..."
    end
  end
end
