require "rails_helper"

describe Vk::GroupSelector do
  context "record is listing" do
    it "retrieves id for listing.kind" do
      record = create :listing, state_id: 32, city_id: 17880

      result = Vk::GroupSelector.from(record)

      expect(result.id).to eq VK_GROUPS["new-york"][:id]
      expect(result.topic_id).to eq VK_GROUPS["new-york"][record.kind]
    end
  end

  context "record is post" do
    context "tag is new-york"
    it "retrieves negative id for new-york" do
      record = create :post, tag_list: "new-york"

      result = Vk::GroupSelector.from(record)

      expect(result.id).to eq(-VK_GROUPS["new-york"][:id])
    end

    context "tag is brooklyn" do
      it "retrieves negative id for new-york" do
        record = create :post, tag_list: "brooklyn"

        result = Vk::GroupSelector.from(record)

        expect(result.id).to eq(-VK_GROUPS["new-york"][:id])
      end
    end
  end
end
