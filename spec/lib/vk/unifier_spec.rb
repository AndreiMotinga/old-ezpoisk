require "rails_helper"

describe Vk::Unifier do
  before { Timecop.freeze(Time.now) }
  after { Timecop.return }

  describe "#unified" do
    it "returns formatted item" do
      group = { kind: "jobs",
                state_id: 34,
                city_id: 17_880 }
      item = { from_id: 216_072_410,
               text: "item text",
               date: 5.minutes.ago,
               attachments: [] }
      atts = double(Vk::Attachments)
      allow(Vk::Attachments).to(receive(:new))
                            .with(item[:attachments])
                            .and_return(atts)
      allow(atts).to receive(:attachments)

      result = Vk::Unifier.new(item, group).unified

      kind = group[:kind].to_sym
      expected_attrs = { title: "Dummy title",
                         kind: kind,
                         category: KINDS[kind][:categories].first,
                         subcategory: KINDS[kind][:subcategories].first,
                         text: item[:text],
                         vk: "https://vk.com/id#{item[:from_id]}",
                         state_id: group[:state_id],
                         city_id: group[:city_id],
                         user_id: 1,
                         created_at: Time.at(5.minutes.ago) }
      expect(result[:attributes]).to eq expected_attrs

      expect(Vk::Attachments).to have_received(:new).with(item[:attachments])
      expect(atts).to have_received(:attachments)
    end
  end
end
