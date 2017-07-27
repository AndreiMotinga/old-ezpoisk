require "rails_helper"

describe Fb::Unifier do
  before { Timecop.freeze(Time.now) }
  after { Timecop.return }

  describe "#unified" do
    it "returns formatted post" do
      group = { kind: "недвижимость",
                state_id: 43,
                city_id: 24_757 }
      item = HashWithIndifferentAccess.new(
        attachments: [],
        from: { name: "Marianna Sumina", id: "101" },
        message: "У нас на работе есть вакансия",
        created_time: 5.minutes.ago
      )

      atts = double(Fb::Attachments)
      allow(Fb::Attachments).to(receive(:new))
                            .with(item[:attachments])
                            .and_return(atts)
      allow(atts).to receive(:attachments)

      result = Fb::Unifier.new(item, group).unified

      kind = group[:kind].to_sym
      subcategory = kind == :"недвижимость" ? "квартира" : "другое"
      rooms = kind == :"недвижимость" ? "комната" : ""
      expected_attrs = { title: "У нас на работе есть вакансия",
                         kind: group[:kind],
                         active: true,
                         category: RU_KINDS[kind][:categories].first,
                         subcategory: subcategory,
                         rooms: rooms,
                         text: item[:message],
                         state_id: group[:state_id],
                         city_id: group[:city_id],
                         user_id: 1,
                         from_name: "Marianna Sumina",
                         fb: "https://www.facebook.com/#{item[:from][:id]}",
                         created_at: 5.minutes.ago }
      expect(result[:attributes]).to eq expected_attrs
      expect(Fb::Attachments).to have_received(:new).with(item[:attachments])
      expect(atts).to have_received(:attachments)
    end
  end
end
