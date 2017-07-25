require "rails_helper"

describe Vk::Unifier do
  before { Timecop.freeze(Time.now) }
  after { Timecop.return }

  describe "#unified" do
    it "returns formatted item" do
      group = { kind: "jobs",
                id: 22558194 ,
                topic: 24112410,
                state_id: 34,
                city_id: 17_880 }
      item = { id: 2056,
               from_id: 216_072_410,
               text: "Фотосессия в Нью-Йорке. Детская, семейная и портретная съемка. Лучшие снимки отобранные",
               date: 5.minutes.ago,
               attachments: [] }
      user = Hashie::Mash.new(
        "first_name": "Andrei",
        "last_name": "Motinga",
      )
      atts = double(Vk::Attachments)
      allow(Vk::Attachments).to(receive(:new))
                            .with(item[:attachments])
                            .and_return(atts)
      allow(atts).to receive(:attachments)

      result = Vk::Unifier.new(item, group, user).unified

      kind = group[:kind].to_sym
      subcategory = kind == :"real-estate" ? "apartment" : "other"
      rooms = kind == :"real-estate" ? "room" : ""
      expected_attrs = { title: "Фотосессия в Нью-Йорке. Детская, семейная и портретная съемка. ...",
                         kind: kind,
                         active: true,
                         category: KINDS[kind][:categories].first,
                         subcategory: subcategory,
                         rooms: rooms,
                         text: item[:text],
                         vk: "https://vk.com/id#{item[:from_id]}",
                         state_id: group[:state_id],
                         city_id: group[:city_id],
                         from_name: "Andrei Motinga",
                         user_id: 1,
                         created_at: Time.at(5.minutes.ago) }
      expect(result[:attributes]).to eq expected_attrs

      expect(Vk::Attachments).to have_received(:new).with(item[:attachments])
      expect(atts).to have_received(:attachments)
    end
  end
end
