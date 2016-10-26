require "rails_helper"

describe Vk::Unifier do
  describe "#unified" do
    it "returns formatted item" do
      group = { id: 225_581_94,
                topic: 241_124_10,
                model: "Job",
                state_id: 32,
                city_id: 17_880 }

      item = HashWithIndifferentAccess.new(
        "from_id": 216_072_410,
        "date": 1_474_723_701,
        "text": "item text",
        "attachments": [
          { "type": "photo", "photo": { "src_xxxbig": "foo.com" } }
        ]
      )
      atts = double(Vk::Attachments)
      allow(Vk::Attachments)
        .to receive(:new)
        .with(item[:attachments])
        .and_return(atts)
      allow(atts).to receive(:attachments)

      result = Vk::Unifier.new(item, group).unified

      expect(result[:date]).to eq Time.at(item[:date])
      expect(result[:text]).to eq item[:text]
      expect(result[:vk]).to eq "https://vk.com/id#{item[:from_id]}"
      expect(result[:fb]).to eq ""
      expect(result[:state_id]).to eq 32
      expect(result[:city_id]).to eq 17_880
      expect(Vk::Attachments)
        .to have_received(:new)
        .with(item[:attachments])
      expect(atts).to have_received(:attachments)
    end
  end
end
