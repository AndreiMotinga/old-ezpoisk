require "rails_helper"

describe Vk::Unifier do
  before { Timecop.freeze(Time.now) }
  after { Timecop.return }

  # todo replace title and text with stubbed calls to media::title and media::text
  describe ".unify" do
    it "returns formatted item" do
      group = { "kind" => "работа",
                "id" => 22558194 ,
                "topic" => 24112410,
                "state_id" => 32,
                "city_id" => 17_880 }
      item = { id: 2056,
               from_id: 216_072_410,
               text: "Детская, семейная и портретная съемка.",
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

      result = Vk::Unifier.unify(item, group, user)

      kind = group["kind"].to_sym
      subcategory = kind == :"недвижимость" ? "квартира" : "другое-разное"
      rooms = kind == :"недвижимость" ? "комната" : ""
      expected_attrs = { title: "Детская, семейная и портретная съемка.",
                         kind: kind,
                         active: false,
                         category: RU_KINDS[kind][:categories].first,
                         subcategory: subcategory,
                         rooms: rooms,
                         text: "Детская, семейная и портретная съемка.",
                         vk: "https://vk.com/id#{item[:from_id]}",
                         state_id: group["state_id"],
                         city_id: group["city_id"],
                         source: "https://vk.com/topic-22558194_24112410?post=2056",
                         created_at: Time.at(5.minutes.ago) }

      expect(result[:attributes]).to eq expected_attrs
      expect(Vk::Attachments).to have_received(:new).with(item[:attachments])
      expect(atts).to have_received(:attachments)
    end
  end
end
